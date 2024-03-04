return {
    'tpope/vim-fugitive',
    keys = {
        { "<leader>gs", vim.cmd.Git, { desc = "fuGitive Status" } }
    },
    config = function()
        local nmap = require("lusedou.keymaps").nmap

        local augroup = vim.api.nvim_create_augroup("Lusedou_Fugitive", {})

        vim.api.nvim_create_autocmd(
            'BufWinEnter',
            {
                group = augroup,
                pattern = "fugitive://*",
                callback = function()
                    if vim.bo.ft ~= "fugitive" then
                        return
                    end

                    local bufnr = vim.api.nvim_get_current_buf()
                    local opts = { buffer = bufnr, remap = false }

                    nmap {
                        "<leader>p",
                        command = function()
                            vim.cmd.Git('push')
                        end,
                        desc = "Push",
                        opts = opts
                    }

                    nmap {
                        "<leader>P",
                        command = function()
                            vim.cmd.Git({ 'pull', '--rebase' })
                        end,
                        desc = "Pull --rebase",
                        opts = opts
                    }

                    nmap {
                        "<leader>t",
                        command = ":Git push -u origin ",
                        desc = "Push -u origin",
                        opts = opts
                    }
                end,
            })
    end
}
