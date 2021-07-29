require('packer').startup({function(use)
  
  use 'scrooloose/nerdtree'
  
  use 'rakr/vim-one'
  use 'folke/tokyonight.nvim'
  use 'kyazdani42/nvim-web-devicons'
  use 'norcalli/nvim-colorizer.lua'
  use 'sheerun/vim-polyglot'
  use 'mhinz/vim-grepper'

  use 'Yggdroot/indentLine'

  use 'christoomey/vim-tmux-navigator'

  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }
  use {
    'neovim/nvim-lspconfig',
    event = 'BufReadPre',
    config = function()
      require('lsp-config')
    end
  }

  use 'glepnir/lspsaga.nvim'
  use 'hrsh7th/nvim-compe'
  use 'windwp/nvim-autopairs'

  use {
    'hoob3rt/lualine.nvim',
    event = 'VimEnter',
    config = function()
      require('custom_lualine')
    end,
    requires = {'kyazdani42/nvim-web-devicons', opt=true}
  }

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

require('colorizer').setup()
require('nvim-autopairs').setup()
require('nvim-autopairs.completion.compe').setup({
  map_cr = true,
  map_complete = true
})

require('kommentary.config').configure_language('default', {
  prefer_single_line_comments = true,
  use_consistent_indentation = true
})

-- Turn on highlighting with treesitter
require'nvim-treesitter.configs'.setup({
  highlight = { enable = true },
  autopairs = { enable = true }
})


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
