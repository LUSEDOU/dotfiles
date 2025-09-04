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
		-- require("neodev").setup({})

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
			-- omnisharp = {
			-- 	enable = false,
			-- 	-- sln or csproj
			-- 	root_dir = lspconfig.util.root_pattern("*.sln", "*.csproj"),
			-- 	capabilities = capabilities,
			-- 	cmd = { "dotnet", vim.fn.stdpath("data") .. "/mason/packages/omnisharp/libexec/OmniSharp.dll" },
			-- 	filetypes = { "cs", "cshtml", "razor" },
			-- 	settings = {
			-- 		FormattingOptions = {
			-- 			-- Enables support for reading code style, naming convention and analyzer
			-- 			-- settings from .editorconfig.
			-- 			EnableEditorConfigSupport = true,
			-- 			-- Specifies whether 'using' directives should be grouped and sorted during
			-- 			-- document formatting.
			-- 			OrganizeImports = true,
			-- 		},
			-- 		RoslynExtensionsOptions = {
			-- 			EnableDecompilationSupport = true,
			-- 			-- Enables support for roslyn analyzers, code fixes and rulesets.
			-- 			EnableAnalyzersSupport = true,
			-- 			-- Enables support for showing unimported types and unimported extension
			-- 			-- methods in completion lists. When committed, the appropriate using
			-- 			-- directive will be added at the top of the current file. This option can
			-- 			-- have a negative impact on initial completion responsiveness,
			-- 			-- particularly for the first few completion sessions after opening a
			-- 			-- solution.
			-- 			EnableImportCompletion = true,
			-- 			-- Only run analyzers against open files when 'enableRoslynAnalyzers' is
			-- 			-- true
			-- 			AnalyzeOpenDocumentsOnly = true,
			-- 		},
			-- 	},
			-- },
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
			basedpyright = {
				enable = false,
				config = {
					analysis = {
						typeCheckingMode = "standard",
					},
				},
			},
		}

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
			if (type(config) == "boolean" and config) or (type(config) == "table" and not config.enable) then
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

		vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
			border = _border,
		})

		vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
			border = _border,
		})

		vim.diagnostic.config({
			float = { border = _border },
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
					command = vim.lsp.buf.hover,
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
					command = vim.lsp.buf.signature_help,
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
