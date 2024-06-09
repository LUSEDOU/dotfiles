-- OCaMl
local autocmd = require 'lusedou.autocommands'.autocmd

-- OCaml Augroup
autocmd {
  group = 'Lusedou.OCaml',
  event = 'BufWinEnter',
  pattern = '*.ml',
  callback = function()
    local nmap = require 'lusedou.keymaps'.nmap
    local notify = require 'fidget.progress.handle'
    local job = require 'plenary.job'

    nmap {
      '<leader>db',
      desc = '[D]une [B]uild',
      command = function()
        local message = notify.create {
          title = "Dune",
          message = "Dune build started",
          lsp_client = { name = "ocamllsp" },
          percentage = 0,
        }
        local thread = job:new {
          command = 'dune',
          args = { 'build' },
          on_stdout = function(_, data)
            if type(data) == 'string' then
              vim.schedule_wrap(function()
                message:report {
                  title = "Dune",
                  message = data,
                  percentage = 50,
                }
              end)
            elseif type(data) == 'table' then
              for key, value in pairs(data) do
                message:report {
                  title = key,
                  message = value,
                  percentage = 50,
                }
              end
            end
          end,
          on_exit = function(_, _, _)
            message:finish()
          end
        }
        thread:start()
        --
        --   local job = job:new {
        --     command = 'dune',
        --   }
        --
        --   message:report({
        --     title = "The task status changed"
        --     message = "Doing another thing...",
        --     percentage = 50,
        --   })
        --
        --   -- You can also cancel the task (errors if not cancellable)
        --   message:cancel()
        --
        --   -- Or mark it as complete (updates percentage to 100 automatically)
        --   message:finish()
      end
    }
  end
}
