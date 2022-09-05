require('packer').startup({function(use)
  
  use 'scrooloose/nerdtree'
  
  -- Theme
  use 'doums/darcula'
  use 'sainnhe/sonokai'
  use 'olimorris/onedarkpro.nvim'
  use 'rakr/vim-one'
  use 'folke/tokyonight.nvim'
  use 'sainnhe/edge'
  use 'kyazdani42/nvim-web-devicons'
  use 'norcalli/nvim-colorizer.lua'
  use 'rmehri01/onenord.nvim'
  use 'morhetz/gruvbox'

  use 'sheerun/vim-polyglot'
  use 'mhinz/vim-grepper'

  use 'Yggdroot/indentLine'

  use 'christoomey/vim-tmux-navigator'
  use 'szw/vim-maximizer'

  use {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
  }
  use 'nvim-treesitter/nvim-treesitter'
  use 'nvim-treesitter/nvim-treesitter-angular'
  -- use 'nvim-treesitter/nvim-treesitter-textobjects'
  use 'nvim-treesitter/playground'

  use 'onsails/lspkind-nvim'
  use {
    'romgrk/nvim-treesitter-context',
    config = function()
      require('treesitter-context').setup({
        enable = true,
        throttle = true
      })
    end
  }

  use { 'RRethy/vim-illuminate' }
  use 'ray-x/lsp_signature.nvim'

  use 'dylon/vim-antlr'
  -- This doesn't really work well yet..
  -- use 'kabouzeid/nvim-lspinstall'
  
  use 'tami5/lspsaga.nvim'

  -- Completion plugin
  -- TODO: Extract to separate file
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/nvim-cmp'
  -- Completion support for luasnip
  use 'L3MON4D3/LuaSnip'
  use 'saadparwaiz1/cmp_luasnip'


  use 'windwp/nvim-autopairs'

  use {
    'hoob3rt/lualine.nvim',
    requires = {'kyazdani42/nvim-web-devicons', opt=true},
  }

  use {
    'nvim-telescope/telescope.nvim',
    requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
  }
  use 'nvim-telescope/telescope-fzy-native.nvim'

  use 'b3nj5m1n/kommentary'
  use 'tpope/vim-fugitive'
  use "b0o/incline.nvim"

end,
config = {
  display = {
    open_fn = require('packer.util').float,
  }
}})

require('mason').setup()
require('mason-lspconfig').setup()
require('lsp-config')

require('onedarkpro').setup({
    theme = 'onedark'
  })
require('colorizer').setup()
require('nvim-autopairs').setup()
require('lsp_signature').setup()

require('custom_lualine')

require('kommentary.config').configure_language('default', {
  prefer_single_line_comments = true,
  use_consistent_indentation = true
})

-- Highlighting the word under the cursor (with vim-illuminate)
vim.g.Illuminate_delay = 0
vim.g.Illuminate_ftblacklist = { 'nerdtree', 'qf' }
vim.cmd([[
  augroup illuminate_augroup
    autocmd!
    autocmd VimEnter * hi link illuminatedWord CursorLine
  augroup END
]])


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
        width = 0.6,
        height = 0.6
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

require('incline').setup({
  window = {
    placement = {
      horizontal = "right",
      vertical = "bottom"
    },
    margin = {
      vertical = 0,
      horizontal = 0
    }
  },
  highlight = {
    groups = {
      InclineNormal = {
        guifg = "yellow3",
        guibg = "#3f3f3f"
      },
      InclineNormalNC = {
        guifg = "yellow3",
        guibg = "#3f3f3f"
      }
    }
  }
})

-- require('snippets')

-- Opens all my vimrc configuration files
_G.edit_my_vimrc = function()
  require('telescope.builtin').find_files({
    prompt_title = 'VimRC Files',
    follow = true,
    cwd = '~/.config/nvim'
  })
end

-- Opens telescope with all the files in the current dir
_G.local_find_files = function()
  local currFileDir = vim.fn.expand('%:h')
  require('telescope.builtin').find_files({
      prompt_title = 'Local dir files',
      follow = true,
      cwd = vim.fn.expand('%:p:h'),
      theme = 'dropdown',
      previewer = false,
      layout_config = {
        height = 0.4,
        width = 0.5
      }
    })
end

-- TODO: Move these to keys.lua
vim.api.nvim_set_keymap('n', '<C-p>', '<cmd>Telescope find_files<CR>', { noremap=true })
vim.api.nvim_set_keymap('n', '<leader>bb', '<cmd>Telescope buffers<CR>', { noremap=true })
vim.api.nvim_set_keymap('n', '<leader>ss', '<cmd>Telescope lsp_document_symbols<CR>', { noremap=true })
vim.api.nvim_set_keymap('n', '<leader>gg', '<cmd>Telescope live_grep<CR>', { noremap=true })
vim.api.nvim_set_keymap('n', '<leader>ff', '<cmd>Telescope grep_string<CR>', { noremap=true })
vim.api.nvim_set_keymap('n', '<leader>fa', ':lua local_find_files()<CR>', { noremap=true })

-- Type :Vimrc to edit my personal vimrc files
vim.cmd('command! Vimrc :lua edit_my_vimrc()<CR>')


-- Close all buffers that are in the background
-- TODO: Complete this!
_G.close_background_buffers = function()
  local all_buffers = vim.fn.getbufinfo()
  local keys = ''
  for key, value in pairs(all_buffers) do
    if value.hidden ~= 1 then
      keys = keys .. key .. ", "
    end
  end
  print("hello " .. keys)
end
