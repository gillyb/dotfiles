-- Neodev must be setup before the Lua language server
require("neodev").setup()

local luasnip = require('luasnip');
local lsp = require('lspconfig')
local cmp = require('cmp')
cmp.setup({
  enabled = function()
    -- disable completion in comments
    local context = require('cmp.config.context')
    -- keep command mode completion enabled when cursor is in a comment
    if (vim.bo.buftype == 'prompt') then
      return false
    end

    if (vim.api.nvim_get_mode().mode == 'c') then
      return true
    else
      return (not context.in_treesitter_capture("comment")
        and not context.in_syntax_group("Comment"))
    end
  end,
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete({}),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    }),
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      --[[ elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump() ]]
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      --[[ elseif luasnip.jumpable(-1) then
        luasnip.jump(-1) ]]
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  }),
})

-- Add border to hover floats (when pressing K)
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = "rounded",
})

-- Setup capabilities
local capabilities = vim.tbl_extend(
  "force",
  vim.lsp.protocol.make_client_capabilities(),
  require('cmp_nvim_lsp').default_capabilities()
)
capabilities.textDocument.completion.completionItem.snippetSupport = true

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  underline = false,
  update_in_insert = false,
  virtual_text = { spacing = 4, prefix = "●" },
  severity_sort = true,
})

-- Patch 'go to definition' so that we always go to the first result
local function patch(result)
  if not vim.tbl_islist(result) or type(result) ~= "table" then
    return result
  end

  return { result[1] }
end

local function handle_gtd(err, result, ctx, ...)
  vim.lsp.handlers['textDocument/definition'](err, patch(result), ctx, ...)
end


-- Configure gutter icons from lsp diagnostics
vim.fn.sign_define('DiagnosticSignWarn', {name = 'DiagnosticSignWarn', text = '', texthl = 'DiagnosticSignWarn'})
vim.fn.sign_define('DiagnosticSignError', {name = 'DiagnosticSignError', text = '', texthl = 'DiagnosticSignError'})
vim.fn.sign_define('DiagnosticSignHint', {name = 'DiagnosticSignHint', text = ' ', texthl = 'DiagnosticSignHint'})
vim.fn.sign_define('DiagnosticSignInfo', {name = 'DiagnosticSignInfo', text = '', texthl = 'DiagnosticSignInfo'})



local function setup(lang_server, opts)
  local merged_opts = vim.tbl_extend('force', {
    capabilities = capabilities
  }, opts or {})

  lsp[lang_server].setup(merged_opts)
end

setup('tsserver', {
  handlers = {
    ['textDocument/definition'] = function(err, result, method, ...)
      if vim.tbl_islist(result) and #result > 1 then
        local filtered_result = { result[1] }
        return vim.lsp.handlers['textDocument/definition'](err, filtered_result, method, ...)
      end

      vim.lsp.handlers['textDocument/definition'](err, result, method, ...)
    end
  }
})
setup('eslint')
setup('bashls')
setup('pyright')
setup('yamlls')
setup('jsonls')
setup('html')
setup('cssls')
setup('clangd')
setup('tailwindcss')
setup('lua_ls', {
  settings = {
    Lua = {
      telemetry = { enable = false },
      diagnostics = { globals = { 'vim' } }
    }
  }
})
