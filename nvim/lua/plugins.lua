require('packer').startup({function()
  
  use 'scrooloose/nerdtree'
  
  use 'rakr/vim-one'
  use 'ryanoasis/vim-devicons'
  use 'mhinz/vim-grepper'

  -- I made some minor changes in this plugin.
  -- Hopefully it will be merged to the original.
  use 'gillyb/lualine.nvim'

  use 'Yggdroot/indentLine'

  use 'christoomey/vim-tmux-navigator'

  use 'neovim/nvim-lspconfig'
  -- use 'kabouzeid/nvim-lspinstall'
  use 'nvim-treesitter/nvim-treesitter'
  use 'glepnir/lspsaga.nvim'
  use 'hrsh7th/nvim-compe'

  use {
    'nvim-telescope/telescope.nvim',
    requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
  }
  use 'nvim-telescope/telescope-fzy-native.nvim'

  use 'b3nj5m1n/kommentary'

end,
config = {
  display = {
    open_fn = require('packer.util').float,
  }
}})

require('kommentary.config').configure_language('default', {
  prefer_single_line_comments = true,
  use_consistent_indentation = true
})

-- Configure my statusline (hoob3rt/lualine)
require'lualine'.setup({
  options = {
    icons_enabled = true,
    theme = 'onedark',
    disabled_filetypes = {'nerdtree'}
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch'},
    lualine_c = {'filename'},
    lualine_x = {'encoding'},
    -- I just want to see line number out of total lines and col, I don't care about percentage
    lualine_y = { '[[%l/%L :%c]]' },
    lualine_z = {
      {
        'diagnostics',
        sources = {'nvim_lsp'},
        sections = {'error', 'warn', 'info', 'hint'},
        color_error = { fg = '#000000' },
        colored = true,
        icons_enabled = true
      }
    }
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {}
})

-- Turn on highlighting with treesitter
require'nvim-treesitter.configs'.setup { highlight = { enable = true } }

-- Custom lsp configuration
require('lsp-config')


-- My custom telescope configuration
require('telescope').setup({
  defaults = {
    -- Some of these default values don't really apply to all pickers
    -- so I define them again in the pickers I use often.
    file_sorter = require('telescope.sorters').get_fzy_sorter,
    layout_strategy = "center",
    theme = 'dropdown',
    mappings = {
      i = {
        -- Move up/down with Ctrl+j/k
        ['<C-j>'] = 'move_selection_next',
        ['<C-k>'] = 'move_selection_previous',
        -- When using 'esc' or 'jk' in insert mode, close the window
        ['<esc>'] = 'close',
        ['jk'] = 'close'
      }
    }
  },
  pickers = {
    buffers = {
      theme = 'dropdown',
      previewer = false,
      sort_lastused = true
    },
    find_files = {
      previewer = false,
      layout_config = {
        height = 0.5
      },
      theme = 'dropdown',
    },
    help_tags = {
      theme = 'dropdown'
    },
    commands = {
      theme = 'dropdown',
      layout_config = {
        height = 0.6
      }
    },
    lsp_document_symbols = {
      previewer = false,
      theme = 'dropdown',
      layout_config = {
        height = 0.6
      }
    }
  },
  extensions = {
    fzy_native = {
      override_generic_sorter = false,
      override_file_sorter = true
    }
  }
})

require('telescope').load_extension('fzy_native')

_G.edit_my_vimrc = function()
  require('telescope.builtin').find_files({
    prompt_title = 'VimRC Files',
    cwd = '~/.config/nvim'
  })
end

vim.api.nvim_set_keymap('n', '<C-p>', '<cmd>Telescope find_files<CR>', { noremap=true })
vim.api.nvim_set_keymap('n', '<leader>bb', '<cmd>Telescope buffers<CR>', { noremap=true })
vim.api.nvim_set_keymap('n', '<leader>ss', '<cmd>Telescope lsp_document_symbols<CR>', { noremap=true })

-- Type :Vimrc to edit my personal vimrc files
vim.cmd('command! Vimrc :lua edit_my_vimrc()<CR>')
