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
}
