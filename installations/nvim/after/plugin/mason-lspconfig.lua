require('mason-lspconfig').setup({
  ensure_installed = {
    -- Language server names take from:
    -- https://github.com/williamboman/mason-lspconfig.nvim?tab=readme-ov-file#default-configuration
    'bashls',
    'clangd',
    'cssls',
    'dockerls',
    'docker_compose_language_service',
    'eslint',
    'html',
    'jsonls',
    'tsserver',
    'lua_ls',
    'marksman',
    'pyright',
    'tailwindcss',
    'yamlls'
  },
  automatic_installation = true
})
