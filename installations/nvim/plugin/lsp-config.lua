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
setup('lua_ls')
setup('pyright')
setup('yamlls')
setup('jsonls')
setup('html')
setup('cssls')
setup('clangd')





-- OLD STUFF HERE.. --


-- Setup capabilities
--[[ local capabilities = vim.tbl_extend(
  "force",
  vim.lsp.protocol.make_client_capabilities(),
  cmp_nvim_lsp.default_capabilities()
)
capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true,
}
capabilities.textDocument.completion.completionItem.snippetSupport = true

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  underline = false,
  update_in_insert = false,
  virtual_text = { spacing = 4, prefix = "●" },
  severity_sort = true,
})

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "single" })
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "single" })

local signs = { Error = " ", Warning = " ", Hint = " ", Information = " " }

for type, icon in pairs(signs) do
  local hl = "LspDiagnosticsSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end ]]



-- Install language servers
-- TODO: Add these to the installation steps of nvim
-- typescript: npm i -g typescript typescript-language-server
-- bash: npm i -g bash-language-server
-- angular: npm i -g @angular/language-server
-- html: npm i -g vscode-langservers-extracted
-- json: npm i -g vscode-langservers-extracted
-- python: npm i -g pyright
-- vim: npm install -g vim-language-server
-- Complete list of language servers here: https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md
--[[ local lsp_config = {
  on_attach = init_lsp,
  capabilities = capabilities
}

nvim_lsp.eslint.setup({
  on_attach = function(client, bufnr)
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      command = "EslintFixAll",
    })
  end,
}) ]]

-- nvim_lsp.tsserver.setup(lsp_config)
-- nvim_lsp.bashls.setup(lsp_config)
-- nvim_lsp.angularls.setup(lsp_config)
-- nvim_lsp.html.setup(lsp_config)
-- nvim_lsp.jsonls.setup(lsp_config)
-- nvim_lsp.pyright.setup(lsp_config)
-- nvim_lsp.vimls.setup(lsp_config)
-- nvim_lsp.clangd.setup(lsp_config)



-- I use nvim-cmp for completion
-- Setup for nvim-cmp
-- local cmp = require('cmp')
-- local lspkind = require("lspkind")


-- Define mappings
-- vim.api.nvim_set_keymap('n', 'gD', ':lua vim.lsp.buf.declaration()<CR>', { noremap = true })
-- vim.api.nvim_set_keymap('n', 'gd', ':lua vim.lsp.buf.definition()<CR>', { noremap = true })
-- vim.api.nvim_set_keymap('n', 'gi', ':lua vim.lsp.buf.implementation()<CR>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', 'gr', ':lua vim.lsp.buf.references()<CR>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', 'K', ':lua vim.lsp.buf.hover({ border="rounded" })<CR>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '[d', ':lua vim.diagnostic.goto_next({ border="rounded" })<CR>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', ']d', ':lua vim.diagnostic.goto_prev({ border="rounded" })<CR>', { noremap = true, silent = true })

--[[ vim.api.nvim_set_keymap('n', ']e',
  ':lua vim.diagnostic.goto_prev({ severity=vim.diagnostic.severity.ERROR, border="rounded" })<CR>',
  { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '[e',
  ':lua vim.diagnostic.goto_next({ severity=vim.diagnostic.severity.ERROR, border="rounded" })<CR>',
  { noremap = true, silent = true }) ]]

-- vim.api.nvim_set_keymap('n', '<leader>gk', ':lua vim.lsp.buf.signature_help({ border="rounded" })<CR>', { noremap = true })
