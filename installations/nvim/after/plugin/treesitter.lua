require('nvim-treesitter.configs').setup({
  ensure_installed = {'c', 'cpp', 'go', 'lua', 'python', 'tsx', 'typescript', 'javascript', 'vimdoc', 'vim'},
  auto_install = true,
  playground = {
    enable = true,
    disable = {},
    updatetime = 25,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<c-x>',
      node_incremental = '<c-x>',
      node_decremental = '<c-z>'
    }
  },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false
  },
  indent = {
    enable = true
  }
})
