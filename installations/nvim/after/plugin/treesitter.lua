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
