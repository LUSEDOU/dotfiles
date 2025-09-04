return {
	"akinsho/flutter-tools.nvim",
	-- enabled = false,
	dependencies = {
		"nvim-lua/plenary.nvim",
		"j-hui/fidget.nvim",
	},
	ft = "dart",
	opts = {
		fvm = true,
		lsp = {
			color = { -- show the derived colours for dart variables
				enabled = true, -- whether or not to highlight color variables at all, only supported on flutter >= 2.10
				background = true, -- highlight the background
				background_color = nil, -- required, when background is transparent (i.e. background_color = { r = 19, g = 17, b = 24},)
				foreground = true, -- highlight the foreground
				virtual_text = true, -- show the highlight using virtual text
				virtual_text_str = "■", -- the virtual text character to highlight
			},
			settings = {
				analysisExcludedFolders = {
					vim.fn.expand("$HOME/AppData/Local/Pub/Cache"),
					vim.fn.expand("$HOME/.pub-cache"),
					vim.fn.expand("/usr/local/flutter"),
				},
			},
		},
	},
	config = true,
}
