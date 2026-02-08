return {
	'askfiy/http-client.nvim',
	ft = { 'http' },
	opts = {},
	keys = {
		{
			"<leader>hh",
			'<cmd>HttpClient sendRequest<CR>',
			desc = "Run HTTP request under cursor",
		},
	},
}
