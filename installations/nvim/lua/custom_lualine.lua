-- Configure my statusline (hoob3rt/lualine)
require('lualine').setup({
  options = {
    icons_enabled = true,
    theme = 'onedark',
    section_separators = { "", "" },
    component_separators = { "", "" },
    disabled_filetypes = {'nerdtree'},
    always_divide_middle = true
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = { 
      { 
        'diagnostics', 
        sources = { 'nvim_lsp' }
      }
    },
    lualine_c = {{'filename', path=1}},
    lualine_x = {},
    lualine_y = {'encoding'},
    -- I just want to see line number out of total lines and col, I don't care about percentage
    lualine_z = { '[[%l/%L :%c]]' },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {
      {
        'diagnostics',
        sources = { 'nvim_lsp' }
      }
    },
    lualine_c = {{'filename', path=1}},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {'nvim-tree'}
})
