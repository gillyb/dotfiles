-- Neodev must be setup before the Lua language server
require("neodev").setup()

local lsp = require('lspconfig')
local cmp_nvim_lsp = require('cmp_nvim_lsp')

-- Add border to hover floats (when pressing K)
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = "rounded",
})

-- Setup capabilities
local capabilities = vim.tbl_extend(
  "force",
  vim.lsp.protocol.make_client_capabilities(),
  cmp_nvim_lsp.default_capabilities()
)
capabilities.textDocument.completion.completionItem.snippetSupport = true

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  underline = false,
  update_in_insert = false,
  virtual_text = { spacing = 4, prefix = "●" },
  severity_sort = true,
})


-- TODO: Fix icons here. THIS WORKS!!!
vim.fn.sign_define('DiagnosticSignWarn', {name = 'DiagnosticSignWarn', text = ' ', texthl = 'DiagnosticSignWarn'})
vim.fn.sign_define('DiagnosticSignError', {name = 'DiagnosticSignError', text = '⁉️ ', texthl = 'DiagnosticSignError'})
vim.fn.sign_define('DiagnosticSignHint', {name = 'DiagnosticSignHint', text = ' ', texthl = 'DiagnosticSignHint'})
vim.fn.sign_define('DiagnosticSignInfo', {name = 'DiagnosticSignInfo', text = ' ', texthl = 'DiagnosticSignInfo'})



local function setup(lang_server, opts)
  local merged_opts = vim.tbl_extend('force', {
    capabilities = capabilities
  }, opts or {})

  lsp[lang_server].setup(merged_opts)
end

setup('tsserver')
setup('eslint')
setup('angularls')
setup('bashls')
setup('pyright')
setup('yamlls')
setup('jsonls')
setup('html')
setup('cssls')
setup('clangd')
setup('lua_ls', {
  settings = {
    Lua = {
      telemetry = { enable = false },
      diagnostics = { globals = { 'vim' } }
    }
  }
})
