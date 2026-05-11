-- Copilot runs the GitHub language server under Node. Node 26+ currently breaks auth with
-- "Response content-type is missing (status=200)" — use Node 22 or 24 LTS.
-- Set NVIM_COPILOT_NODE to the full path of an LTS `node.exe` before starting Nvim.
-- See https://github.com/zbirenbaum/copilot.lua/issues/695
--
-- Optional: NVIM_COPILOT_USE_BINARY=1 uses the downloaded Copilot binary instead of Node for the LSP
-- (may avoid the Node 26 HTTP bug). See :h copilot.lua server.
--
-- Real HTTP proxy: vim.g.copilot_proxy = "http://127.0.0.1:PORT" before setup.

local copilot_node = vim.env.NVIM_COPILOT_NODE
if copilot_node == nil or copilot_node == "" then
	copilot_node = "node"
end

local copilot_server = vim.env.NVIM_COPILOT_USE_BINARY == "1" and { type = "binary" } or { type = "nodejs" }

return {
	"zbirenbaum/copilot.lua",
	-- Do not run auth on every Lazy sync; sign in manually with :Copilot auth
	lazy = false,
	keys = {
		{
			"<C-c>",
			function()
				require("copilot.panel").open({
					position = "right",
					size = 0.5,
				})

				vim.cmd("wincmd l")
			end,
			desc = "Open Copilot panel",
		},
	},
	opts = {
		server = copilot_server,
		copilot_node_command = copilot_node,
		panel = {
			auto_refresh = true,
			layout = {
				position = "right",
			},
		},
		suggestion = {
			debounce = 50,
			auto_trigger = true,
			keymap = {
				accept = nil,
				dismiss = nil,
				next = nil,
				prev = nil,
			},
		},
		-- Defaults already cover most code; these are explicit for .NET / TS stacks.
		filetypes = {
			yaml = true,
			markdown = true,
			gitcommit = true,
			svn = true,
			cs = true,
			typescript = true,
			javascript = true,
			typescriptreact = true,
			javascriptreact = true,
		},
	},
	config = function(_, opts)
		local copilot = require("copilot")
		local suggestion = require("copilot.suggestion")
		local imap = require("lusedou.keymaps").imap

		copilot.setup(opts)

		local function remap(key, command)
			imap({
				key,
				command = function()
					if suggestion.is_visible() then
						command()
					else
						local keyy = vim.api.nvim_replace_termcodes(key, true, false, true)
						vim.api.nvim_feedkeys(keyy, "n", false)
					end
				end,
				opts = { silent = true },
			})
		end

		remap("<Tab>", suggestion.accept)
		remap("/", suggestion.dismiss)
		remap("]]", suggestion.next)
		remap("[[", suggestion.prev)
	end,
}
