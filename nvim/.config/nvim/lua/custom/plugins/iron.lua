return {
	"hkupty/iron.nvim",
	filetypes = { "python" },
	keys = {
		{
			"<space>rs",
			"<cmd>IronRepl<cr>",
			desc = "Open Iron REPL",
		},
		{
			"<space>rr",
			"<cmd>IronRestart<cr>",
			desc = "Restart Iron",
		},
		{
			"<space>rF",
			"<cmd>IronFocus<cr>",
			desc = "Focus Iron",
		},
		{
			"<space>rh",
			"<cmd>IronHide<cr>",
			desc = "Hide Iron",
		},
	},
	config = function()
		local plugin = require("iron.core")
		local opts = {
			config = {
				-- Whether a repl should be discarded or not
				scratch_repl = true,
				-- Your repl definitions come here
				repl_definition = {
					python = {
						-- Can be a table or a function that
						-- returns a table (see below)
						command = { "ipython", "--no-autoindent" },
						format = require("iron.fts.common").bracketed_paste_python
					},
				},
				-- How the repl window will be displayed
				-- See below for more information
				repl_open_cmd = require("iron.view").right(0.4),
			},
			-- Iron doesn't set keymaps by default anymore.
			-- You can set them here or manually add keymaps to the functions in iron.core
			keymaps = {
				send_motion = "<space>rc",
				visual_send = "<space>rc",
				send_file = "<space>rf",
				send_line = "<space>rl",
				send_mark = "<space>rm",
				mark_motion = "<space>rmc",
				mark_visual = "<space>rmc",
				remove_mark = "<space>rmd",
				cr = "<space>r<cr>",
				interrupt = "<space>r<space>",
				exit = "<space>rq",
				clear = "<space>rx",
			},
			-- If the highlight is on, you can change how it looks
			-- For the available options, check nvim_set_hl
			highlight = {
				italic = true,
			},
			ignore_blank_lines = true, -- ignore blank lines when sending visual select lines
		}

		plugin.setup(opts)
	end,
}
