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

ls.config.set_config({
    enable_autosnippets = true,
    history = true,
    updateevents = 'TextChanged,TextChangedI',
    region_check_events = 'CursorHold',
    delete_check_events = 'TextChanged',
    ext_opts = {
        [".md"] = {
            active = true,
        },
    },
    ext_base_prio = 2,
    ext_prio_increase = 1,
})

vim.keymap.set('i', '<C-l>', function() ls.expand() end, { silent = true, desc = 'Expand snippet' })
vim.keymap.set({ 'i', 's' }, '<C-k>', function() ls.jump(1) end, { silent = true, desc = 'Jump' })
vim.keymap.set({ 'i', 's' }, '<C-j>', function() ls.jump(-1) end, { silent = true, desc = 'Jump' })

vim.keymap.set({ 'i', 's' }, '<C-e>', function()
    if ls.choice_active() then
        ls.change_choice(1)
    else
        ls.exit_current()
    end
end, { silent = true, desc = 'Jump' })

local get_visual = function(_, parent)
    if (#parent.snippet.env.LS_SELECT_RAW > 0) then
        return sn(nil, i(1, parent.snippet.env.LS_SELECT_RAW))
    else -- If LS_SELECT_RAW is empty, return a blank insert node
        return sn(nil, i(1))
    end
end

-- all
ls.add_snippets('all', {
    s('test', {
        t('test'),
        i(1),
    }),

    s(
        { -- Table 1: snippet parameters
            trig = "hi",
            dscr = "An autotriggering snippet that expands 'hi' into 'Hello, world!'",
            regTrig = false,
            priority = 100,
        },
        {                       -- Table 2: snippet nodes (don't worry about this for now---we'll cover nodes shortly)
            t("Hello, world!"), -- A single text node
        }
    ),
})

-- LaTex
ls.add_snippets('tex', {
    -- \frac
    s({
            trig = '([^%a])ff',
            dscr = "Expands 'ff' into LaTeX's \\frac{}{} command.",
            regTrig = true,
            wordTrig = false,
            snippetType = "autosnippet",
        },
        fmta(
            [[<>\frac{<>}{<>}]],
            {
                f(function(_, snip) return snip.captures[1] end),
                i(1),
                i(2)
            }
        )
    ),
    -- Equation
    s({
            trig = "eq",
            dscr = "Expands 'eq' into an equation environment"
        },
        fmta(
            [[
               \begin{equation*}
                   <>
               \end{equation*}
             ]],
            { i(0) }
        )
    ),
    s({ trig = "env", snippetType = "autosnippet" },
        fmta(
            [[
              \begin{<>}
                  <>
              \end{<>}
            ]],
            {
                i(1),
                i(2),
                rep(1), -- this node repeats insert node i(1)
            }
        )
    ),

    s({
        trig = "mk",
        dscr = "Expands 'mk' into a math environment",
        snippetType = "autosnippet",
    }, fmta(
        "$<>$",
        { i(1) },
        { regTrig = true }
    )),

    s({
            trig = "tii",
            dscr = "Expands 'tii' into LaTeX's textit{} command.",
        },
        fmta("\\textit{<>}",
            {
                d(1, get_visual),
            }
        )
    ),

    s({
            trig = "tb",
            dscr = "Expands 'tb' into LaTeX's textbf{} command.",
        },
        fmta("\\textbf{<>}",
            {
                d(1, get_visual),
            }
        )
    ),

    s({
            trig = "ul",
            dscr = "Expands 'ul' into LaTeX's underline command.",
        },
        fmta("\\underline{<>}",
            {
                d(1, get_visual),
            }
        )
    ),

    s({
            trig = "em",
            dscr = "Expands 'em' into LaTeX's emph{} command.",
        },
        fmta("\\emph{<>}",
            {
                d(1, get_visual),
            }
        )
    ),

    s({
            trig = "tt",
            dscr = "Expands 'tt' into LaTeX's texttt{} command.",
        },
        fmta("\\texttt{<>}",
            {
                d(1, get_visual),
            }
        )
    ),

    s({
            trig = "([^%a])mm",
            wordTrig = false,
            regTrig = true,
            snippetType = "autosnippet",
            dstcr = "Expands 'mm' into LaTeX's math mode.",
        },
        fmta(
            "<>$<>$",
            {
                f(function(_, snip) return snip.captures[1] end),
                d(1, get_visual),
            }
        )
    ),

    s({
            trig = "dm",
            dscr = "Expands 'dm' into LaTeX's displaymath environment.",
            snippetType = "autosnippet",
        },
        fmta(
            [[
            \[
            <>
            \] <>
            ]],
            {
                d(1, get_visual),
                i(0)
            }
        )
    ),

    s({
            trig = "([A-Za-z])(\\d)",
            wordTrig = false,
            regTrig = true,
            dscr = "Expands 'a1' into LaTeX's \\alpha_1 command.",
            snippetType = "autosnippet",
        },
        fmta(
            "<>_<>",
            {
                f(function(_, snip) return snip.captures[1] end),
                f(function(_, snip) return snip.captures[2] end),
            }
        )
    ),

    s({
            trig = "//",
            dscr = "Expands '//' into LaTeX's \\frac{}{} command.",
            snippetType = "autosnippet",
        },
        fmta("\\frac{<>}{<>}",
            {
                i(1),
                i(2),
            }
        )
    ),

    s({
        -- ((\d+)|(\d*)(\\)?([A-Za-z]+)((\^|_)(\{\d+\}|\d))*)/
        trig = "((\\d+))|(\\d*)(\\\\)?([A-Za-z]+)((\\^|_)(\\{\\d+\\}|\\d))*)/",
        wordTrig = false,
        regTrig = true,
        snippetType = "autosnippet",
    }, fmta(
        "<>^{<>}",
        {
            f(function(_, snip) return snip.captures[1] end),
            f(function(_, snip) return snip.captures[2] end),
        }
    )),
})

-- Markdown
ls.add_snippets('markdown', {
    s({
        trig = "**",
        snippetType = "autosnippet",
    }, fmta(
        "**<>**",
        {
            d(1, get_visual),
        }
    )),

    s({
        trig = "__",
        snippetType = "autosnippet",
    }, fmta(
        "_<>_",
        {
            d(1, get_visual),
        }
    )),
})
