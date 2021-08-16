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
  use 'dylon/vim-antlr'
  -- This doesn't really work well yet..
  -- use 'kabouzeid/nvim-lspinstall'

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
  use 'tpope/vim-fugitive'

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


-- TODO: Extract to separate file
-- My custom telescope configuration
local actions = require('telescope.actions')
require('telescope').setup({
  defaults = {
    -- Some of these default values don't really apply to all pickers
    -- so I define them again in the pickers I use often.
    file_sorter = require('telescope.sorters').get_fzy_sorter,
    generic_sorter = require('telescope.sorters').get_fzy_sorter,
    layout_strategy = "center",
    theme = 'dropdown',
    mappings = {
      i = {
        -- Move up/down with Ctrl+j/k
        ['<C-j>'] = 'move_selection_next',
        ['<C-k>'] = 'move_selection_previous',
        -- When using 'esc' or 'jk' in insert mode, close the window
        ['<esc>'] = 'close',
        ['jk'] = 'close',
        -- Send all results to a quickfix list
        ['<C-q>'] = actions.send_to_qflist + actions.open_qflist
      }
    }
  },
  pickers = {
    buffers = {
      theme = 'dropdown',
      previewer = false,
      sort_lastused = true,
      layout_config = {
        width = 0.6
      }
    },
    find_files = {
      follow = true,
      previewer = false,
      layout_config = {
        height = 0.5,
        width = 0.7
      },
      theme = 'dropdown',
    },
    live_grep = {
      previewer = false,
      theme = 'dropdown',
      layout_config = {
        height = 0.7,
        width = 0.8
      }
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
        height = 0.6,
        width = 0.7
      }
    }
  },
  extensions = {
    fzy_native = {
      override_generic_sorter = true,
      override_file_sorter = true
    }
  }
})

require('telescope').load_extension('fzy_native')

_G.edit_my_vimrc = function()
  require('telescope.builtin').find_files({
    prompt_title = 'VimRC Files',
    follow = true,
    cwd = '~/.config/nvim'
  })
end

_G.local_file_browser = function(dir)
  local currFileDir = vim.fn.expand('%:h')
  require('telescope.builtin').file_browser({
      prompt_title = 'Current Dir Files',
      follow = true,
      cwd = vim.fn.expand('%:p:h'),
      theme = 'dropdown',
      previewer = false,
      layout_config = {
        height = 0.5,
        width = 0.5
      }
    })
end

-- TODO: Move these to keys.lua
vim.api.nvim_set_keymap('n', '<C-p>', '<cmd>Telescope find_files<CR>', { noremap=true })
vim.api.nvim_set_keymap('n', '<leader>bb', '<cmd>Telescope buffers<CR>', { noremap=true })
vim.api.nvim_set_keymap('n', '<leader>ss', '<cmd>Telescope lsp_document_symbols<CR>', { noremap=true })
vim.api.nvim_set_keymap('n', '<leader>gg', '<cmd>Telescope live_grep<CR>', { noremap=true })
vim.api.nvim_set_keymap('n', '<leader>fa', ':lua local_file_browser()<CR>', { noremap=true })

-- Type :Vimrc to edit my personal vimrc files
vim.cmd('command! Vimrc :lua edit_my_vimrc()<CR>')
