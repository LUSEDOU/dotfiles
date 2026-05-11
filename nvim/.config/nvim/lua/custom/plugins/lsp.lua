return {
	"neovim/nvim-lspconfig",
	dependencies = {
		-- "folke/neodev.nvim",
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",

		{ "j-hui/fidget.nvim", opts = {} },
	},
	config = function()
		-- Register default `vim.lsp.config` entries from nvim-lspconfig.
		require("lspconfig")

		-- Windows: GUI Neovim/Cursor often omits Scoop shims and `dotnet tool` globals from PATH.
		local function prepend_path_dir(dir)
			if not dir or vim.uv.fs_stat(dir) == nil then
				return
			end
			dir = vim.fs.normalize(dir)
			local sep = vim.fn.has("win32") == 1 and ";" or ":"
			local path = vim.env.PATH or ""
			if path:sub(1, #dir + #sep) == dir .. sep then
				return
			end
			vim.env.PATH = dir .. sep .. path
		end

		if vim.fn.has("win32") == 1 and vim.env.USERPROFILE then
			local home = vim.env.USERPROFILE
			prepend_path_dir(vim.fs.joinpath(home, "scoop", "shims"))
			prepend_path_dir(vim.fs.joinpath(home, ".dotnet", "tools"))
		end

		--- OmniSharp: `scoop install omnisharp` (not Mason). Optional full path: `$env:NVIM_OMNISHARP`.
		local function find_omnisharp_executable()
			local envp = vim.env.NVIM_OMNISHARP
			if envp and envp ~= "" then
				local p = vim.fs.normalize(envp)
				if vim.uv.fs_stat(p) then
					return p
				end
			end
			if vim.fn.has("win32") == 1 and vim.env.USERPROFILE then
				for _, name in ipairs({ "OmniSharp.exe", "omnisharp.exe" }) do
					local p = vim.fs.joinpath(vim.env.USERPROFILE, "scoop", "shims", name)
					if vim.uv.fs_stat(p) then
						return vim.fs.normalize(p)
					end
				end
			end
			for _, name in ipairs({ "OmniSharp", "omnisharp" }) do
				local p = vim.fn.exepath(name)
				if p ~= "" then
					return p
				end
			end
			return nil
		end

		local omni_exe = find_omnisharp_executable()
		local omni_cmd = omni_exe and {
			omni_exe,
			"-z",
			"--hostPID",
			tostring(vim.fn.getpid()),
			"DotNet:enablePackageRestore=false",
			"--encoding",
			"utf-8",
			"--languageserver",
		} or nil

		--- csharp-ls: `dotnet tool install --global csharp-ls`. Set `$env:NVIM_USE_CSHARP_LS=1` to use it
		--- for `cs` buffers; OmniSharp is then limited to `vb`, `cshtml`, `razor` so two servers do not fight.
		local use_csharp_ls = vim.env.NVIM_USE_CSHARP_LS == "1"
		local omni_filetypes = use_csharp_ls and { "vb", "cshtml", "razor" } or { "cs", "vb", "cshtml", "razor" }

		local capabilities = nil

		if pcall(require, "cmp_nvim_lsp") then
			capabilities = require("cmp_nvim_lsp").default_capabilities()
		end

		if capabilities then
			for k, v in pairs(capabilities) do
				if v == vim.NIL then
					---@diagnostic disable-next-line: cast-local-type
					capabilities[k] = nil
				end
			end
		end

		-- local lspconfig = require("lspconfig")

		local servers = {
			gopls = {
				settings = {
					gopls = {
						hints = {
							assignVariableTypes = true,
							compositeLiteralFields = true,
							compositeLiteralTypes = true,
							constantValues = true,
							functionTypeParameters = true,
							parameterNames = true,
							rangeVariableTypes = true,
						},
					},
				},
			},
			lua_ls = {
				migrated = true,
				on_init = function(client)
					if client.workspace_folders then
						local path = client.workspace_folders[1].name
						if
							path ~= vim.fn.stdpath("config")
							and (vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc"))
						then
							return
						end
					end

					client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
						runtime = {
							-- Tell the language server which version of Lua you're using (most
							-- likely LuaJIT in the case of Neovim)
							version = "LuaJIT",
							-- Tell the language server how to find Lua modules same way as Neovim
							-- (see `:h lua-module-load`)
							path = {
								"lua/?.lua",
								"lua/?/init.lua",
							},
						},
						-- Make the server aware of Neovim runtime files
						workspace = {
							checkThirdParty = false,
							library = {
								vim.env.VIMRUNTIME,
								-- Depending on the usage, you might want to add additional paths
								-- here.
								-- '${3rd}/luv/library'
								-- '${3rd}/busted/library'
							},
							-- Or pull in all of 'runtimepath'.
							-- NOTE: this is a lot slower and will cause issues when working on
							-- your own configuration.
							-- See https://github.com/neovim/nvim-lspconfig/issues/3189
							-- library = {
							--   vim.api.nvim_get_runtime_file('', true),
							-- }
						},
					})
				end,
				-- server_capabilities = {
				-- 	semanticTokensProvider = vim.NIL,
				-- },
				settings = {
					Lua = {},
				},
			},
			-- dartls = {
			-- 	enable = false,
			-- 	manual_install = true,
			-- },
			ocamllsp = {
				manual_install = true,
				settings = {
					codelens = { enable = true },
					inlayHints = { enable = true },
				},

				filetypes = {
					"ocaml",
					"ocaml.interface",
					"ocaml.menhir",
					"ocaml.cram",
				},
				server_capabilities = {
					semanticTokensProvider = false,
				},
				get_language_id = function(_, ftype)
					return ftype
				end,
			},
			--- OmniSharp: install with `scoop install omnisharp` (see `find_omnisharp_executable` above).
			omnisharp = vim.tbl_extend("force", {
				filetypes = omni_filetypes,
				manual_install = true,
				settings = {
					FormattingOptions = {
						EnableEditorConfigSupport = true,
						OrganizeImports = true,
					},
					RoslynExtensionsOptions = {
						EnableDecompilationSupport = true,
						EnableAnalyzersSupport = true,
						EnableImportCompletion = true,
						AnalyzeOpenDocumentsOnly = true,
					},
				},
			}, omni_cmd and { cmd = omni_cmd } or {}),
			--- TypeScript / JavaScript (Deno projects are skipped by upstream `root_dir` logic).
			vtsls = {},
			--- Angular (vscode-ng-language-service); needs `node_modules` with @angular/language-service.
			angularls = {},
			-- biome = true,
			denols = {
				settings = {
					deno = {
						enable = true,
						lint = true,
						unstable = true,
						suggest = {
							imports = {
								autoDiscover = true,
							},
						},
					},
				},
			},
			sourcekit = {
				enable = false,
				manual_install = true,
			},
			-- basedpyright = {
			-- 	enable = false,
			-- 	config = {
			-- 		analysis = {
			-- 			typeCheckingMode = "standard",
			-- 		},
			-- 	},
			-- },
		}

		if use_csharp_ls then
			servers.csharp_ls = {
				manual_install = true,
			}
		end

		local servers_to_install = vim.tbl_filter(function(key)
			local t = servers[key]
			if type(t) == "table" then
				return not t.manual_install
			else
				return t
			end
		end, vim.tbl_keys(servers))

		require("mason").setup()
		local ensure_installed = {
			"stylua",
			"lua_ls",
			"vtsls",
			"angular-language-server",
			-- OmniSharp: use `scoop install omnisharp`, not Mason.
			-- "tailwind-language-server",
		}

		vim.list_extend(ensure_installed, servers_to_install)
		require("mason-tool-installer").setup({ ensure_installed = ensure_installed })
		-- local mason_lspconfig = require("mason-lspconfig")

		local mason_servers = require("mason-lspconfig").get_installed_servers()
		if mason_servers then
			for _, server in ipairs(mason_servers) do
				if not servers[server] then
					servers[server] = true
				end
			end
		end

		local custom_capabilities_server = {
			-- lua = {
			-- 	semanticTokensProvider = nil,
			-- },
			-- biome = false,
		}

		for server, config in pairs(servers) do
			local enabled = type(config) == "boolean" and config
				or (type(config) == "table" and config.enable ~= false)

			if enabled then
				if config == true then
					config = {}
				end

				config = vim.tbl_deep_extend("force", {}, {
					capabilities = capabilities,
				}, config)

				if custom_capabilities_server[server] ~= nil then
					if custom_capabilities_server[server] == false then
						config.capabilities = nil
					else
						for k, v in pairs(custom_capabilities_server[server]) do
							config.capabilities[k] = v
						end
					end
				end

				-- if config.migrated then
				vim.lsp.config[server] = config
				vim.lsp.enable(server)
				-- else
				-- 	require("lspconfig")[server].setup(config)
				-- end
			end
		end

		local _border = "rounded"

		-- Nvim 0.12+: vim.lsp.with is deprecated; pass opts to vim.lsp.buf.* and/or set 'winborder'.
		pcall(vim.api.nvim_set_option_value, "winborder", _border, {})

		vim.diagnostic.config({
			float = { border = _border },
		})

		local function lsp_log_path()
			if vim.lsp.log and vim.lsp.log.get_filename then
				return vim.lsp.log.get_filename()
			end
			---@diagnostic disable-next-line: deprecated
			return vim.lsp.get_log_path and vim.lsp.get_log_path()
		end

		vim.api.nvim_create_user_command("LspInfo", "checkhealth vim.lsp", {
			desc = "Show LSP client/config status (replaces legacy :LspInfo)",
		})

		vim.api.nvim_create_user_command("LspLog", function()
			local path = lsp_log_path()
			if path and path ~= "" then
				vim.cmd.split(vim.fn.fnameescape(path))
			else
				vim.notify("LSP log path not available", vim.log.levels.WARN)
			end
		end, { desc = "Open Neovim LSP log (vim.lsp.log)" })

		vim.api.nvim_create_user_command("LspRestart", function(o)
			local a = vim.trim(o.args or "")
			if a == "" then
				vim.cmd("lsp restart")
			else
				vim.cmd("lsp restart " .. a)
			end
		end, {
			nargs = "*",
			desc = "Restart LSP clients on this buffer (:lsp restart …)",
		})

		vim.api.nvim_create_autocmd("LspAttach", {
			callback = function(args)
				local bufnr = args.buf
				local client = assert(vim.lsp.get_client_by_id(args.data.client_id), "must have valid client")

				local settings = servers[client.name]
				if type(settings) ~= "table" then
					settings = {}
				end

				-- if client.supports_method("textDocument/inlayHint") then
				-- end

				local kmap = require("lusedou.keymaps")
				local nmap = kmap.nmap
				local imap = kmap.imap

				local opts = { buffer = bufnr, remap = false }

				-- vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"

				nmap({
					"<leader>ci",
					command = function()
						local isEnable = vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr })
						vim.schedule(function()
							print(isEnable)
						end)
						vim.lsp.inlay_hint.enable(not isEnable, { bufnr = bufnr })
					end,
					desc = "toggle inlay hints",
					opts = opts,
				})

				nmap({
					"<leader>ca",
					command = vim.lsp.buf.code_action,
					desc = "view code actions",
					opts = opts,
				})

				nmap({
					"gd",
					command = function()
						vim.lsp.buf.definition()
						vim.cmd("normal! zz")
					end,
					desc = "view definition",
					opts = opts,
				})

				nmap({
					"gD",
					command = vim.lsp.buf.declaration,
					desc = "view declaration",
					opts = opts,
				})

				nmap({
					"gT",
					command = vim.lsp.buf.type_definition,
					desc = "view type definition",
					opts = opts,
				})

				nmap({
					"K",
					command = function()
						vim.lsp.buf.hover({ border = _border })
					end,
					desc = "view definition",
					opts = opts,
				})

				nmap({
					"<leader>vd",
					command = vim.diagnostic.open_float,
					desc = "view diagnostic",
					opts = opts,
				})

				nmap({
					"<leader>vws",
					command = vim.lsp.buf.workspace_symbol,
					desc = "view workspace symbol",
					opts = opts,
				})

				nmap({
					"<leader>vr",
					command = vim.lsp.buf.references,
					desc = "view references",
					opts = opts,
				})

				nmap({
					"<leader>vn",
					command = vim.lsp.buf.rename,
					desc = "rename",
					opts = opts,
				})

				imap({
					"<C-h>",
					command = function()
						vim.lsp.buf.signature_help({ border = _border })
					end,
					desc = "Go help",
					opts = opts,
				})

				-- local filetype = vim.bo[bufnr].filetype
				-- if disable_semantic_tokens[filetype] then
				-- 	client.server_capabilities.semanticTokensProvider = nil
				-- end
				--
				-- -- Override server capabilities
				-- if settings.server_capabilities then
				-- 	for k, v in pairs(settings.server_capabilities) do
				-- 		if v == vim.NIL then
				-- 			---@diagnostic disable-next-line: cast-local-type
				-- 			v = nil
				-- 		end
				--
				-- 		client.server_capabilities[k] = v
				-- 	end
				-- end
			end,
		})
	end,
}
