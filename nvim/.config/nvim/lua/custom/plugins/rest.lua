return {
	"askfiy/http-client.nvim",
	ft = { "http" },
	cmd = { "HttpClient" },
	keys = {
		{
			"<leader>sr",
			"<cmd>HttpClient sendRequest<cr>",
		},
	},
	opts = {
		hooks = {
			process_response = function(response)
				if response.err then
					return response
				else
					-- Pretty print JSON responses
					local content_type = response.headers["content-type"] or ""
					if content_type:find("application/json") then
						local ok, json = pcall(vim.fn.json_decode, response.body)
						if ok then
							response.body = vim.fn.json_encode(json, { indent = true })
						end
					end
					return response
				end
			end,
		},
	},
	config = function(_, opts)
		opts.ensure_installed = opts.ensure_installed or {}
		table.insert(opts.ensure_installed, "http")

		require("http-client").setup(opts)

		-- Treesitter integration
	end,
}
