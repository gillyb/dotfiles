-- require('lazy').setup({
  -- mhinz/vim-grepper
  -- 'dylon/vim-antlr',                 -- lsp plugin for ANTLR
-- }, {
  -- concurrency = 4
-- })

-- Config setup for indent-blankline
require('ibl').setup({
  indent = {
    char = '╎'
  },
  scope = {
    enabled = false
  }
});



-- Snippets --
-- TODO: Move this to separate file
local ls = require('luasnip');
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require("luasnip.util.events")
local ai = require("luasnip.nodes.absolute_indexer")
local extras = require("luasnip.extras")
local l = extras.lambda
local rep = extras.rep
local p = extras.partial
local m = extras.match
local n = extras.nonempty
local dl = extras.dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local conds = require("luasnip.extras.expand_conditions")
local postfix = require("luasnip.extras.postfix").postfix
local types = require("luasnip.util.types")
local parse = require("luasnip.util.parser").parse_snippet
local ms = ls.multi_snippet

ls.add_snippets('javascript', {
  -- 'd' to create an empty <div>
  s('d', {
    t('<div className="">'),
    i(0),
    t('</div>')
  }),

  -- 'us' to add useState
  s('us', {
    t('const ['), i(1), t(', set'), i(1), t('] = useState('), i(2), t(');')
  }),
  -- 'fc' for 'function component'
  s('fc', {
    t('import {useState} from \'react\';\n\nexport default function '),
    i(1),
    t('(props) {\n\nreturn (\n\n\n);\n}')
  })
})
