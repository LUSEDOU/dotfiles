return {
	"stevearc/conform.nvim",
	dependencies = {
		"williamboman/mason.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	keys = {
		{
			-- Customize or remove this keymap to your liking
			"<leader>f",
			function()
				require("conform").format({ async = true, lsp_format = "fallback" })
			end,
			mode = "",
			desc = "Format buffer",
		},
	},
	config = function(_)
		local ft = {
			lua = "stylua",
			cs = "csharpier",
			sql = "sqlfmt",
			python = "black",
			-- javascript = { { "prettier", "prettierd" } },
			-- yaml = { "yamlls", "prettierd" },
		}

		local function flatten(table)
			local function loop(item, result)
				if type(item) == "table" then
					for _, v in pairs(item) do
						loop(v, result)
					end
				else
					result[#result + 1] = item
				end
			end
			local result = {}
			loop(table, result)
			-- unique
			local hash = {}
			local unique_result = {}
			for _, v in pairs(result) do
				if not hash[v] then
					hash[v] = true
					unique_result[#unique_result + 1] = v
				end
			end
			return unique_result
		end

		local ensure_to_install = flatten(ft)

		require("mason-tool-installer").setup({
			ensure_to_install = ensure_to_install,
		})

		local conform = require("conform")

		for fit, tools in pairs(ft) do
			---@type string[]|table
			local tool = type(tools) == "string" and { tools } or tools
			conform.formatters_by_ft[fit] = tool
		end

	end,
}
