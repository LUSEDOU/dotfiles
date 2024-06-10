local cmd = require 'lusedou.autocommands'

cmd.autocmd {
  event = 'BufWinEnter',
  pattern = '*.dart',
  group = 'Lusedou_Flutter',
  callback = function()
    if vim.bo.ft ~= 'dart' then
      return
    end
    print('Flutter: Formatting file... 1')

    local nmap = require('lusedou.keymaps').nmap
    local Job = require 'plenary.job'
    local ui = require 'fidget.progress'.handle

    nmap {
      '<leader>br',
      command = function()
        local ex = require 'flutter-tools.executable'
        ex.dart(function(path)
          local job_ui = ui.create {
            title = 'Dart Build Runner',
            lsp_client = { name = 'flutter custom tools' },
            progress = 0,
          }
          Job:new({
            ---@diagnostic disable-next-line: assign-type-mismatch
            command = path,
            on_start = function()
              job_ui.message = 'Start building...'
            end,
            args = { 'run', 'build_runner', 'build', '--delete-conflicting-outputs' },
            on_stdout = function(_, data, _)
              -- [INFO] Generating build script completed, took 347ms
              -- [INFO] Reading cached asset graph completed, took 507ms
              -- [INFO] Checking for updates since last build completed, took 1.7s
              if type(data) == "string" then
                job_ui:report {
                  title = 'Build Runner',
                  message = data,
                  percentage = 100,
                }
              elseif type(data) == "table" then
                for _, v in ipairs(data) do
                  job_ui:report {
                    title = 'Build Runner',
                    message = v,
                    percentage = 100,
                  }
                end
              end
            end,
            on_stderr = function(_, data, _)
              if type(data) == "string" then
                job_ui:report {
                  title = 'Build Runner',
                  message = data,
                  percentage = 100,
                }
              elseif type(data) == "table" then
                for _, v in ipairs(data) do
                  job_ui:report {
                    title = 'Build Runner',
                    message = v,
                    percentage = 100,
                  }
                end
              end
            end,
            on_exit = vim.schedule_wrap(function()
              -- job_ui:report {
              --     title = 'Build Runner',
              --     message = 'Build completed',
              --     percentage = 100,
              -- }
              job_ui:finish()
            end)
          }):start()
        end)
      end
    }
  end
}
