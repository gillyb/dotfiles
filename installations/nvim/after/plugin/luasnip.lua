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

local function capitalize(str)
  return (str:gsub('^%l', string.upper))
end

local js_snippets = {
  -- todo comment
  s('todo', {
    t('// TODO: '), i(0)
  }),

  -- 'log' to type 'console.log'
  s('log', {
    t('console.log(`'),
    i(1),
    t('`);'),
    i(0)
  }),
  -- console.info(``);
  s('linfo', {
    t('console.info(`'), i(1), t('`);'), i(0)
  }),
  s('lwarn', {
    t('console.warn(`'), i(1), t('`);'), i(0)
  }),
  s('ldebug', {
    t('console.debug(`'), i(1), t('`);'), i(0)
  }),


  -- 'd' to create an empty <div>
  s('d', {
    t('<div className='), i(1), t('>'),
    i(0),
    t('</div>')
  }),

  -- 'state' to add useState
  s('state', {
    t('const ['),
    i(1),
    f(function (args) return ', set' .. capitalize(args[1][1]) end, {1}),
    t('] = useState('),
    i(2),
    t(');'),
    i(0)
  }),
  -- 'eff' to add useEffect
  s('eff', {
    t({ 'useEffect(() => {', i(1), '}, [', i(2), '])', i(0) })
  }),

  -- 'fc' for 'function component'
  s('fc', {
    t({'import {useState} from \'react\';', '', 'export default function '}),
    i(1),
    t({'(props) {', '', 'return (', '', '', ');', '}'})
  }),

  -- 'ec' for 'export const ...'
  s('ec', {
    t({'export const '}), i(1)
  }),

  -- 'jsp'/'jss' for JSON.parse / JSON.stringify respectively
  s('jsp', {
    t('JSON.parse('), i(1), t(')'), i(0)
  }),
  s('jss', {
    t('JSON.stringify('), i(1), t(')'), i(0)
  }),

  -- 'anon' for anonymous function
  s('anon', {
    t('('), i(1), t(') => '), i(0)
  }),

  -- 'if'
  s('if', {
    t('if ('), i(1), t(') {'), t({''}),
    i(0),
    t({'', '}'})
  }),

  -- 'doc' to add big js comments
  s('doc', {
    t({'/**', ' * '}), i(1), t({'', ' */'})
  })
};

ls.add_snippets('javascript', js_snippets);
ls.add_snippets('typescript', js_snippets);
ls.add_snippets('typescriptreact', js_snippets);


-- Bind keymaps for luasnip --
-- Ctrl+L/J to jump forward and back
vim.keymap.set({"i", "s"}, "<C-L>", function() ls.jump( 1) end, {silent = true})
vim.keymap.set({"i", "s"}, "<C-J>", function() ls.jump(-1) end, {silent = true})
