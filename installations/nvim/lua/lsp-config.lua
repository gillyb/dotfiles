local nvim_lsp = require('lspconfig')
local cmp_lsp = require('cmp_nvim_lsp')

local function init_lsp(client, bufnr)
  -- For illuminating word under the cursor
  -- if client.resolved_capabilities.document_highlight then
  --   require('illuminate').on_attach(client)
  -- end
  vim.api.nvim_set_keymap('n', ']e',
    ':lua vim.diagnostic.goto_prev({ severity=vim.diagnostic.severity.ERROR, border="rounded" })<CR>',
    { noremap = true, silent = true })

  vim.api.nvim_set_keymap('n', '[e',
    ':lua vim.diagnostic.goto_next({ severity=vim.diagnostic.severity.ERROR, border="rounded" })<CR>',
    { noremap = true, silent = true })
end

-- Attach to language servers
local capabilities = cmp_lsp.default_capabilities(vim.lsp.protocol.make_client_capabilities())

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
-- TODO: Add these to the installation steps of nvim
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

lsp_config.eslint.setup({
  on_attach = function(client, bufnr)
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      command = "EslintFixAll",
    })
  end,
})

nvim_lsp.tsserver.setup(lsp_config)
nvim_lsp.bashls.setup(lsp_config)
nvim_lsp.angularls.setup(lsp_config)
nvim_lsp.html.setup(lsp_config)
nvim_lsp.jsonls.setup(lsp_config)
nvim_lsp.pyright.setup(lsp_config)
nvim_lsp.vimls.setup(lsp_config)
nvim_lsp.clangd.setup(lsp_config)



-- I use nvim-cmp for completion
-- Setup for nvim-cmp
local cmp = require('cmp')
local lspkind = require("lspkind")

cmp.setup({
  enabled = function()
    if (require("cmp.config.context").in_treesitter_capture("comment") == true or require("cmp.config.context").in_syntax_group("Comment")) then
      return false
    else
      return true
    end
  end,
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = {
    ["<Tab>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "s" }),
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.close(),
    ["<CR>"] = cmp.mapping.confirm({ select = true })
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'buffer' },
  }),
  formatting = {
    format = lspkind.cmp_format({
      mode = 'symbol_text', -- show symbols and text
      maxwidth = 50,        -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
      preset = 'codicons',
      symbol_map = {
        Text = "",
        Method = "",
        Function = "",
        Constructor = "",
        Field = "ﰠ",
        Variable = "",
        Class = "ﴯ",
        Interface = "",
        Module = "",
        Property = "ﰠ",
        Unit = "塞",
        Value = "",
        Enum = "",
        Keyword = "",
        Snippet = "",
        Color = "",
        File = "",
        Reference = "",
        Folder = "",
        EnumMember = "",
        Constant = "",
        Struct = "פּ",
        Event = "",
        Operator = "",
        TypeParameter = ""
      },
    })
  }
})

require('nvim-treesitter.configs').setup({
  auto_install = true,
  playground = {
    enable = true,
    disable = {},
    updatetime = 25,
  },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false
  },
  indent = {
    enable = true
  }
})

-- Configure .g4 files as antlr syntax
vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, { pattern = '*.g4', command = 'set filetype=antlr4' })


-- Define mappings
vim.api.nvim_set_keymap('n', 'gD', ':lua vim.lsp.buf.declaration()<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', 'gd', ':lua vim.lsp.buf.definition()<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', 'gi', ':lua vim.lsp.buf.implementation()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'gr', ':lua vim.lsp.buf.references()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'K', ':lua vim.lsp.buf.hover({ border="rounded" })<CR>', { noremap = true, silent = true })
--[[ vim.api.nvim_set_keymap('n', '[d',
  ':lua vim.diagnostic.goto_next({ severity=vim.diagnostic.severity.ERROR, border="rounded" })<CR>',
  { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', ']d', ':lua vim.diagnostic.goto_prev({ border="rounded" })<CR>',
  { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', ']e',
  ':lua vim.diagnostic.goto_prev({ severity=vim.diagnostic.severity.ERROR, border="rounded" })<CR>',
  { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '[e',
  ':lua vim.diagnostic.goto_next({ severity=vim.diagnostic.severity.ERROR, border="rounded" })<CR>',
  { noremap = true, silent = true }) ]]

vim.api.nvim_set_keymap('n', '<leader>gk', ':lua vim.lsp.buf.signature_help({ border="rounded" })<CR>',
  { noremap = true })
