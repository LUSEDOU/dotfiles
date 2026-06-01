return {
	{
		"nvim-treesitter/nvim-treesitter-context",
		lazy = true,
		after = "nvim-treesitter",
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
		after = "nvim-treesitter",
		lazy = true,
		opts = {
			move = {
				enable = true,
				set_jumps = true, -- whether to set jumps in the jumplist
				-- LazyVim extention to create buffer-local keymaps
				keys = {
					goto_next_start = {
						["]f"] = "@function.outer",
						["]c"] = "@class.outer",
						["]a"] = "@parameter.inner",
					},
					goto_next_end = { ["]F"] = "@function.outer", ["]C"] = "@class.outer", ["]A"] = "@parameter.inner" },
					goto_previous_start = {
						["[f"] = "@function.outer",
						["[c"] = "@class.outer",
						["[a"] = "@parameter.inner",
					},
					goto_previous_end = {
						["[F"] = "@function.outer",
						["[C"] = "@class.outer",
						["[A"] = "@parameter.inner",
					},
				},
			},
		},
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		main = "nvim-treesitter.configs",
		branch = "master",
		event = "BufReadPre",
		lazy = false,
		opts = {
			ensure_installed = { "lua", "vim", "vimdoc", "go", "bash", "dart", "ocaml", "markdown", "json" },
			ignore_install = { "latex" },
			sync_install = false,
			auto_install = true,
			indent = { enable = true, disable = { "python", "dart" } },
			folds = { enable = true },
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},
		},
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)
		end,
	},
}
