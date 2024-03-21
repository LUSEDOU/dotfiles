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

    vim.o.rtp = vim.o.rtp .. "/home/lusedou/.opam/default/share/ocp-indent/vim"

    vim.opt_local.shiftwidth = 2
    vim.keymap.set("n", "<space>cp", require("ocaml.mappings").dune_promote_file, { buffer = 0 })

    vim.cmd.colorscheme 'rose-pine'
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

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
      end
    }
  end
}

local ls = require('luasnip')
local extras = require('luasnip.extras')
local _fmt = require('luasnip.extras.fmt')
local fmt = _fmt.fmt
local fmta = _fmt.fmta
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local rep = extras.rep

ls.add_snippets('ocaml', {
  -- while
  s({
    trig = 'while',
    dscr = [[
          Expands 'while' into a while loop
          while <> do
            <>
          done<>
        ]],
    -- snippetType = "autosnippet",
    -- regTrig = true,
    -- wordTrig = false,
  }, fmta(
    "while <> do\n  <>\ndone<>",
    {
      i(1),
      i(2),
      i(0)
    }
  )),

  -- for variable = start_value to end_value do
  --   expression
  -- done
  s({
      trig = 'fork',
      dscr = "Expands 'fork' into a for to loop",
      -- regTrig = true,
      -- wordTrig = false,
      -- snippetType = "autosnippet",
    },
    fmta(
      [[
      for <> = <> to <> do
        <>
      done<>]],
      {
        i(1),
        i(2),
        i(3),
        i(4),
        i(0)
      }
    )
  ),

  -- for variable = start_value downto end_value do
  --   expression
  -- done
  s({
      trig = 'forj',
      dscr = "Expands 'forj' into a for downto loop",
      -- wordTrig = false,
      -- snippetType = "autosnippet",
    },
    fmta(
      [[
      for <> = <> downto <> do
        <>
      done<>
      ]],
      {
        i(1),
        i(2),
        i(3),
        i(4),
        i(0)
      }
    )
  ),

  s({
    trig = 'ifelse',
    dscr = [[
          Expands 'ifelse' into an if statement
          if <> then <> else <> <>
        ]],
    -- snippetType = "autosnippet",
    -- regTrig = true,
  }, fmta(
    "if <> then <> else <> <>",
    {
      i(1),
      i(2),
      i(3),
      i(0)
    }
  )),

  -- if
  s({
    trig = 'if',
    dscr = [[
          Expands 'if' into an if statement
          if <> then <> <>
        ]],
    -- snippetType = "autosnippet",
    -- regTrig = true,
  }, fmta(
    "if <> then <> <>",
    {
      i(1),
      i(2),
      i(0)
    }
  )),

  s({
    trig = 'match',
    dscr = [[
          Expands 'match' into a match statement
          match {} with
          | {} -> {}
          | {} -> {}
          end
        ]],
    -- snippetType = "autosnippet",
    -- regTrig = true,
  }, fmt(
    [[
    match {} with
    | {} -> {}
    | {} -> {}
    ]],
    {
      i(1),
      i(2),
      i(3),
      i(4),
      i(0)
    }
  )),

  -- function
  s({
    trig = 'fun',
    dscr = [[
          Expands 'fun' into a function
          let {} = fun {} -> {}
        ]],
    -- snippetType = "autosnippet",
    -- regTrig = true,
  }, fmt(
    "let {} = fun {} -> {}",
    {
      i(1),
      i(2),
      i(0)
    }
  )),

  -- function
  s({
    trig = 'function',
    dscr = [[
          Expands 'function' into a function
          let {} = function
          | {} -> {}
          | {} -> {}
        ]],
    -- snippetType = "autosnippet",
    -- regTrig = true,
  }, fmt(
    [[
    let {} = function
    | {} -> {}
    | {} -> {}
    ]],
    {
      i(1),
      i(2),
      i(3),
      i(4),
      i(0)
    }
  )),

  -- try
  s({
    trig = 'try',
    dscr = [[
          Expands 'try' into a try statement
          try
            {}
          with Exception -> {} {}
        ]],
    -- snippetType = "autosnippet",
    -- regTrig = true,
  }, fmt(
    [[
    try
      {}
    with Exception -> {} {}
    ]],
    {
      i(1),
      i(2),
      i(0)
    }
  )),
})
