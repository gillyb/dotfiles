return {
  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    config = function()
      pcall(require('nvim-treesitter.install').update { with_sync = true })
    end,
  },
  'nvim-treesitter/playground', -- To see how treesitter parses our code
  {
    'romgrk/nvim-treesitter-context',
    config = function()
      require('treesitter-context').setup({
        enable = true,
        throttle = true
      })
    end
  },
}
