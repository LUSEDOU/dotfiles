return {
	"nvim-neotest/neotest",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-neotest/nvim-nio",
		"nvim-treesitter/nvim-treesitter",
		"antoinemadec/FixCursorHold.nvim",
		{
			"sidlatau/neotest-dart",
		},
	},
	keys = {
		{
			"<leader>tt",
			function()
				require("neotest").run.run()
			end,
		},
		{
			"<leader>tf",
			function()
				require("neotest").run.run(vim.fn.expand("%"))
			end,
		},
		{
			"<leader>ts",
			function()
				require("neotest").run.stop()
			end,
		},
		{
			"<leader>to",
			function()
				require("neotest").output_panel.toggle()
			end,
		},
	},
	opts = function()
		---@type neotest.Config
		return {
			adapters = {
				require("neotest-dart")({
					-- command = 'fvm flutter',
					use_fvm = true,
				}),
			},
		}
	end,
	-- config = function()
	-- 	require("neotest").setup({
	-- 		adapters = {
	-- 			require("neotest-dart")({
	-- 				-- command = 'fvm flutter',
	-- 				use_fvm = true,
	-- 			}),
	-- 		},
	-- 	})
	-- end,
}
