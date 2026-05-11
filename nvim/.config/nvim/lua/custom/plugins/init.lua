return {
	-- Themes
	{
		"rebelot/kanagawa.nvim",
		{ "rose-pine/neovim", name = "rose-pine" },
		"rebelot/kanagawa.nvim",
		"RRethy/base16-nvim",
	},

	{
		"xiyaowong/transparent.nvim",
		priority = 1001,
		lazy = false,
		opts = true,
		config = function()
			require("transparent").toggle(true)
		end,
	},

	-- Theme
	{
		"ajmwagar/vim-deus",
		priority = 1000,
		lazy = false,
		config = function()
			require("lusedou.color").load_theme("deus")
		end,
	},

	-- Comment
	{
		"numToStr/Comment.nvim",
		opts = {},
		event = "BufReadPre",
	},

	{
		"tpope/vim-sleuth",
		event = "BufReadPre",
	},

	-- Which Key
	{
		"folke/which-key.nvim",
		opts = {},
	},
	{
		"NoahTheDuke/vim-just",
		ft = { "just" },
	},

	{ import = "custom.plugins.autopairs" },
	{ import = "custom.plugins.colors" },
	{ import = "custom.plugins.completion" },
	{ import = "custom.plugins.conform" },
	{ import = "custom.plugins.copilot" },
	{ import = "custom.plugins.dadbod" },
	{ import = "custom.plugins.flutter" },
	{ import = "custom.plugins.fugitive" },
	{ import = "custom.plugins.fzf-lua" },
	{ import = "custom.plugins.harpoon" },
	{ import = "custom.plugins.iron" },
	{ import = "custom.plugins.lsp" },
	{ import = "custom.plugins.luasnip" },
	{ import = "custom.plugins.markdown-preview" },
	{ import = "custom.plugins.neotest" },
	{ import = "custom.plugins.ocaml" },
	{ import = "custom.plugins.oil" },
	{ import = "custom.plugins.omnisharp" },
	{ import = "custom.plugins.rest" },
	{ import = "custom.plugins.scala" },
	{ import = "custom.plugins.telescope" },
	{ import = "custom.plugins.trouble" },
	{ import = "custom.plugins.treesitter" },
	{ import = "custom.plugins.undotree" },
	{ import = "custom.plugins.vimtex" },
	{ import = "custom.plugins.zenmode" },
}
