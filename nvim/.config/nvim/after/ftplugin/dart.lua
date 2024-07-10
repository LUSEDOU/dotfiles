local cmd = require 'lusedou.autocommands'

cmd.autocmd {
  event = 'BufWinEnter',
  pattern = '*.dart',
  group = 'Lusedou_Flutter',
  callback = function()
    if vim.bo.ft ~= 'dart' then
      return
    end

    vim.cmd.colorscheme 'kanagawa'
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

    local nmap = require('lusedou.keymaps').nmap
    local Job = require 'plenary.job'
    local ui = require 'fidget.progress'.handle


    nmap {
      '<leader>br',
      command = function()
        local ex = require 'flutter-tools.executable'
        ex.dart(function(path)
          ---@type ProgressHandle[]
          local jobs = {}
          local index = 1
          jobs[1] = ui.create {
            title = 'Building',
            lsp_client = { name = 'dart run build_runner build' },
            progress = 0,
          }

          local function printf(message)
            vim.schedule(function()
              print(message)
            end)
          end

          -- local track = ''
          -- local function bc(breadcrumb)
          --   track = track .. ' '.. breadcrumb
          --   printf(track)
          -- end
          local cwd = vim.fn.getcwd()
          local hasError = false

          local function log_fail(message)
            local log = io.open(cwd .. '/build_runner.log', 'a')
            if log == nil then
              return
            end
            log:write(message .. '\n')
            log:close()
            hasError = true
          end

          local function report(data)
            if data == '' then
              return
            end

            local status, message = data:match("%[(%w+)%]%s(.*)")
            local job = jobs[index]

            if status ~= "INFO" then
              if job then
                if status == "SEVERE" then
                  job:report {
                    message = 'Write to build_runner.log for more details',
                  }
                end
              end
              log_fail(data)
            else
              if job == nil then
                --bc('NIL')
                return
              end

              if message:match('%.%.+$') then
                index = index + 1
                jobs[index] = ui.create {
                  title = message:match("(.-)%.%.+$"),
                  lsp_client = { name = 'dart run build_runner build' },
                  progress = 0,
                }
                --bc('New')
                return
              end

              local took = message:match("took (%d+%.?%d*%w+)")
              if took then
                job:report {
                  message = 'Took ' .. took,
                  done = true,
                }
                jobs[index] = nil
                index = index - 1
                --bc('Completed')
                return
              end

              local elapsed = message:match("(%d+%.?%d*s) elapsed")
              local cactions, tactions = message:match("(%d+)/(%d+) actions")
              if elapsed and cactions and tactions then
                job:report {
                  message = elapsed .. ' elapsed',
                  percentage = (cactions / tactions) * 100,
                }
                --bc('Elapsed')
                return
              end

              job.message = message
              --bc('Message')

              -- local title = message:match("^[%a%s]*")
              -- job = ui.create {
              --   title = title,
              --   lsp_client = { name = 'dart run build_runner build' },
              --   progress = 0,
              -- }
            end
          end
          Job:new({
            ---@diagnostic disable-next-line: assign-type-mismatch
            command = path,
            args = { 'run', 'build_runner', 'build', '--delete-conflicting-outputs' },
            on_stdout = function(_, data, _)
              if type(data) == "string" then
                report(data)
              elseif type(data) == "table" then
                printf(table)
                for _, v in ipairs(data) do
                  report(v)
                end
              end
            end,
            on_stderr = function(_, data, _)
              -- write to log
              log_fail(data)
            end,
            on_exit = vim.schedule_wrap(function()
              jobs = {}
              if hasError then
                -- split window vertically and open cwd .. '/build_runner.log'
                vim.cmd('vsplit ' .. cwd .. '/build_runner.log')
              end
            end)
          }):start()
        end)
      end
    }
  end
}
