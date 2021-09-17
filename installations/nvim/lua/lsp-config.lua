local nvim_lsp = require('lspconfig')

local function init_lsp(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Define mappings
  buf_set_keymap('n', 'gD', ':lua vim.lsp.buf.declaration()<CR>', { noremap=true })
  buf_set_keymap('n', 'gd', ':lua vim.lsp.buf.definition()<CR>', { noremap=true })
  buf_set_keymap('n', 'gi', ':lua vim.lsp.buf.implementation()<CR>', { noremap=true, silent=true })
  buf_set_keymap('n', 'gr', ':lua vim.lsp.buf.references()<CR>', { noremap=true, silent=true })
  buf_set_keymap('n', 'K', ':lua vim.lsp.buf.hover({ border="rounded" })<CR>', { noremap=true, silent=true })
  buf_set_keymap('n', '[d', ':lua vim.lsp.diagnostic.goto_next({ border="rounded" })<CR>', { noremap=true, silent=true })
  buf_set_keymap('n', ']d', ':lua vim.lsp.diagnostic.goto_prev({ border="rounded" })<CR>', { noremap=true, silent=true })
  buf_set_keymap('n', '<leader>gk', ':lua vim.lsp.buf.signature_help({ border="rounded" })<CR>', { noremap=true })

  -- For illuminating word under the cursor
  require('illuminate').on_attach(client)
end

-- Attach to language servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = { "documentation", "detail", "additionalTextEdits" },
}


-- Automatically update diagnostics
-- This doesn't really work - don't know why yet...
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  underline = true,
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
end

-- Setup all language servers we installed already.
-- To install more language servers: `:LspInstall <language_server>`
-- list over here: https://github.com/kabouzeid/nvim-lspinstall#bundled-installers
-- local function setup_language_servers()
--   require('lspinstall').setup()
--   local installed_servers = require('lspinstall').installed_servers()
--   for _, server in pairs(installed_servers) do
--     nvim_lsp[server].setup({
--       on_attach = init_lsp,
--       capabilities = capabilities
--     })
--   end
-- end
-- setup_language_servers()
-- Automatically reload after installing a new language server so we don't have to
-- restart neovim
-- require('lspinstall').post_install_hook = function()
  -- setup_language_servers()
  -- vim.cmd('bufdo e')
-- end


-- Install language servers
-- typescript: npm i -g typescript typescript-language-server
-- bash: npm i -g bash-language-server
-- angular: npm i -g @angular/language-server
-- html: npm i -g vscode-langservers-extracted
-- json: npm i -g vscode-langservers-extracted
-- python: npm i -g pyright
-- vim: npm install -g vim-language-server
-- Complete list of language servers here: https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md
local lsp_config = {
  on_attach = init_lsp,
  capabilities = capabilities
}
nvim_lsp.tsserver.setup(lsp_config)
nvim_lsp.bashls.setup(lsp_config)
nvim_lsp.angularls.setup(lsp_config)
nvim_lsp.html.setup(lsp_config)
nvim_lsp.jsonls.setup(lsp_config)
nvim_lsp.pyright.setup(lsp_config)
nvim_lsp.vimls.setup(lsp_config)


-- I use nvim-compe for completion
require('compe').setup {
  enabled = true,
  autocomplete = true,
  debug = false,
  min_length = 1,
  preselect = 'enable',
  throttle_time = 80,
  source_timeout = 200,
  resolve_timeout = 800,
  incomplete_delay = 400,
  max_abbr_width = 100,
  max_kind_width = 100,
  max_menu_width = 100,
  border = "rounded",
  documentation = {
    -- border = { '', '' ,'', ' ', '', '', '', ' ' }, -- the border option is the same as `|help nvim_open_win|`
    -- border = {"╔", "═" ,"╗", "║", "╝", "═", "╚", "║"},
    border = "rounded",
    winhighlight = "NormalFloat:CompeDocumentation,FloatBorder:CompeDocumentationBorder",
    max_width = 120,
    min_width = 60,
    max_height = math.floor(vim.o.lines * 0.3),
    min_height = 1,
  },

  source = {
    path = true,
    buffer = true,
    calc = false,
    nvim_lsp = true,
    nvim_lua = true,
    vsnip = true,
    ultisnips = true,
    luasnip = true,
  }
}

-- Configure .g4 files as antlr syntax
vim.cmd([[
  au BufRead,BufNewFile *.g4 set filetype=antlr4
]])
require('treesitter-context').setup({
    enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
    throttle = true, -- Throttles plugin updates (may improve performance)
})
