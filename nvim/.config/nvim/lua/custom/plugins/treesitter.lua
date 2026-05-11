--- Neovim 0.12+: core highlighting is `vim.treesitter.start()`; nvim-treesitter `main`
--- installs parsers/queries and optional indent. See `:h news-0.12` and nvim-treesitter README.
---
--- On Windows, `tree-sitter build` may pick `cl.exe` (MSVC). If that fails or `-I` is broken,
--- set CC/CXX to MinGW or Clang when they are on PATH (nvim-treesitter `main` ignores the old
--- `require("nvim-treesitter.install").compilers` API).
local function ensure_treesitter_compiler_env()
	if vim.env.CC and vim.env.CC ~= "" then
		return
	end
	if vim.fn.has("win32") ~= 1 then
		return
	end
	local pick ---@type { cc: string, cxx: string }?
	if vim.fn.executable("gcc") == 1 then
		pick = { cc = "gcc", cxx = "g++" }
	elseif vim.fn.executable("clang") == 1 then
		pick = { cc = "clang", cxx = "clang++" }
	elseif vim.fn.executable("x86_64-w64-mingw32-gcc") == 1 then
		pick = { cc = "x86_64-w64-mingw32-gcc", cxx = "x86_64-w64-mingw32-g++" }
	end
	if pick then
		vim.env.CC = pick.cc
		vim.env.CXX = pick.cxx
	end
end

local parser_names = {
	"bash",
	"c_sharp",
	"css",
	"dart",
	"go",
	"html",
	"javascript",
	"json",
	"lua",
	"markdown",
	"ocaml",
	"tsx",
	"typescript",
	"vim",
	"vimdoc",
}

return {
	{
		"nvim-treesitter/nvim-treesitter-context",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		keys = {
			{
				"[c",
				function()
					require("treesitter-context").go_to_context(vim.v.count1())
				end,
				desc = "Previous context",
			},
			{
				"]c",
				function()
					require("treesitter-context").next()
				end,
				desc = "Next context",
			},
		},
		opts = {
			max_lines = 3,
		},
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		branch = "main",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			require("nvim-treesitter-textobjects").setup({
				select = {
					lookahead = true,
				},
			})
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		lazy = false,
		init = ensure_treesitter_compiler_env,
		build = function()
			ensure_treesitter_compiler_env()
			vim.cmd("TSUpdate")
		end,
		config = function()
			ensure_treesitter_compiler_env()
			require("nvim-treesitter").setup({})
			require("nvim-treesitter").install(parser_names)

			local grp = vim.api.nvim_create_augroup("lusedou-treesitter", { clear = true })
			vim.api.nvim_create_autocmd("FileType", {
				group = grp,
				callback = function(ev)
					vim.api.nvim_buf_call(ev.buf, function()
						if pcall(vim.treesitter.start) then
							vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
						end
					end)
				end,
			})
		end,
	},
}
