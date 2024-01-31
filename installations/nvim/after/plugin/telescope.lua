local actions = require('telescope.actions')
local lga_actions = require('telescope-live-grep-args.actions')

require('telescope').setup({
  defaults = {
    -- Some of these default values don't really apply to all pickers
    -- so I define them again in the pickers I use often.
    -- file_sorter = require('telescope.sorters').get_fzy_sorter,
    -- generic_sorter = require('telescope.sorters').get_fzy_sorter,
    file_ignore_patterns = { 
      "package-lock.json"
    },
    layout_strategy = "center",
    theme = 'dropdown',
    mappings = {
      i = {
        -- Move up/down with Ctrl+j/k
        ['<c-j>'] = 'move_selection_next',
        ['<c-k>'] = 'move_selection_previous',
        -- When using 'esc' or 'jk' in insert mode, close the window
        ['<esc>'] = 'close',
        ['jk'] = 'close',
        -- Send all results to a quickfix list
        ['<C-q>'] = actions.send_to_qflist + actions.open_qflist,
        -- Ctrl-u will add quotes to the text, so we can send parameters to ripgrep
        ['<C-u>'] = lga_actions.quote_prompt()
      }
    }
  },
  pickers = {
    buffers = {
      theme = 'dropdown',
      previewer = false,
      sort_lastused = true,
      ignore_current_buffer = true,
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
      theme = 'dropdown'
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
    },
    live_grep_args = {
      auto_quoting = true
    }
  }
})

-- require('telescope').load_extension('fzy_native')
require('telescope').load_extension('fzf')

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

vim.api.nvim_set_keymap('n', '<C-p>', '<cmd>Telescope find_files<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>bb', '<cmd>Telescope buffers<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>ss', '<cmd>Telescope lsp_document_symbols<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>gg', ':lua require("telescope").extensions.live_grep_args.live_grep_args()<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>ff', '<cmd>Telescope grep_string<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>tg', '<cmd>Telescope git_status<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>fa', ':lua local_find_files()<CR>', { noremap = true })

-- Type :Vimrc to edit my personal vimrc files
vim.cmd('command! Vimrc :lua edit_my_vimrc()<CR>')
