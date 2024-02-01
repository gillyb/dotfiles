return {
  -- Shows git differences in the gutter
  'lewis6991/gitsigns.nvim',
  config = function()
    require('gitsigns').setup()
  end
}
