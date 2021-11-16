require('packer').startup({function(use)
  
  use 'scrooloose/nerdtree'
  
  -- Theme
  use 'olimorris/onedarkpro.nvim'
  use 'rakr/vim-one'
  use 'folke/tokyonight.nvim'
  use 'kyazdani42/nvim-web-devicons'
  use 'norcalli/nvim-colorizer.lua'

  use 'sheerun/vim-polyglot'
  use 'mhinz/vim-grepper'

  use 'Yggdroot/indentLine'

  use 'christoomey/vim-tmux-navigator'
  use 'szw/vim-maximizer'

  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    opt = true,
    event = "BufRead",
    requires = {
      "nvim-treesitter/playground",
      "nvim-treesitter/nvim-treesitter-textobjects"
    },
    config = function()
      require('nvim-treesitter.configs').setup({
        highlight = { 
          enable = true,
          additional_vim_regex_highlighting = false
        },
        autopairs = { enable = true },
        textobjects = {
          move = {
            enable= true,
            set_jumps = true,
            go_to_next_start = {
              ["]]"] = "@function.inner"
            },
            go_to_previous_start = {
              ["[["] = "@function.inner"
            }
          }
        },
        playground = {
          enable = true,
          disable = {},
          updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
          persist_queries = true, -- Whether the query persists across vim sessions
          keybindings = {
            toggle_query_editor = "o",
            toggle_hl_groups = "i",
            toggle_injected_languages = "t",
            toggle_anonymous_nodes = "a",
            toggle_language_display = "I",
            focus_language = "f",
            unfocus_language = "F",
            update = "R",
            goto_node = "<cr>",
            show_help = "?",
          },
        },
      })
    end
  } 
  use {
    'neovim/nvim-lspconfig',
    event = 'BufReadPre',
    config = function()
      require('lsp-config')
    end
  }
  use {
    'romgrk/nvim-treesitter-context',
    after = 'nvim-treesitter',
    config = function()
      require('treesitter-context').setup({
        enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
        throttle = true, -- Throttles plugin updates (may improve performance)
      })
    end
  }
  use {
    'RRethy/vim-illuminate',
    event = 'CursorHold',
    module = 'illuminate'
  }
  use 'ray-x/lsp_signature.nvim'

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

  use {
    '~/dev/octo.nvim'
    -- 'pwntester/octo.nvim'
  }

end,
config = {
  display = {
    open_fn = require('packer.util').float,
  }
}})

require('onedarkpro').setup({
    theme = 'onedark'
  })
require('colorizer').setup()
require('nvim-autopairs').setup()
require('nvim-autopairs.completion.compe').setup({
  map_cr = true,
  map_complete = true
})
require('lsp_signature').setup()

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
    autocmd VimEnter * hi illuminatedWord cterm=underline gui=underline
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

require('octo').setup({
  default_remote = {"upstream", "origin"}; -- order to try remotes
  gitlab = {
    enabled = true,
    remote_prefix = "xdr"
  },
  reaction_viewer_hint_icon = "";         -- marker for user reactions
  user_icon = " ";                        -- user icon
  timeline_marker = "";                   -- timeline marker
  timeline_indent = "2";                   -- timeline indentation
  right_bubble_delimiter = "";            -- Bubble delimiter
  left_bubble_delimiter = "";             -- Bubble delimiter
  github_hostname = "";                    -- GitHub Enterprise host
  snippet_context_lines = 4;               -- number or lines around commented lines
  file_panel = {
    size = 10,                             -- changed files panel rows
    use_icons = true                       -- use web-devicons in file panel
  },
  mappings = {
    issue = {
      close_issue = "<space>ic",           -- close issue
      reopen_issue = "<space>io",          -- reopen issue
      list_issues = "<space>il",           -- list open issues on same repo
      reload = "<C-r>",                    -- reload issue
      open_in_browser = "<C-b>",           -- open issue in browser
      copy_url = "<C-y>",                  -- copy url to system clipboard
      add_assignee = "<space>aa",          -- add assignee
      remove_assignee = "<space>ad",       -- remove assignee
      create_label = "<space>lc",          -- create label
      add_label = "<space>la",             -- add label
      remove_label = "<space>ld",          -- remove label
      goto_issue = "<space>gi",            -- navigate to a local repo issue
      add_comment = "<space>ca",           -- add comment
      delete_comment = "<space>cd",        -- delete comment
      next_comment = "]c",                 -- go to next comment
      prev_comment = "[c",                 -- go to previous comment
      react_hooray = "<space>rp",          -- add/remove 🎉 reaction
      react_heart = "<space>rh",           -- add/remove ❤️ reaction
      react_eyes = "<space>re",            -- add/remove 👀 reaction
      react_thumbs_up = "<space>r+",       -- add/remove 👍 reaction
      react_thumbs_down = "<space>r-",     -- add/remove 👎 reaction
      react_rocket = "<space>rr",          -- add/remove 🚀 reaction
      react_laugh = "<space>rl",           -- add/remove 😄 reaction
      react_confused = "<space>rc",        -- add/remove 😕 reaction
    },
    pull_request = {
      checkout_pr = "<space>po",           -- checkout PR
      merge_pr = "<space>pm",              -- merge PR
      list_commits = "<space>pc",          -- list PR commits
      list_changed_files = "<space>pf",    -- list PR changed files
      show_pr_diff = "<space>pd",          -- show PR diff
      add_reviewer = "<space>va",          -- add reviewer
      remove_reviewer = "<space>vd",       -- remove reviewer request
      close_issue = "<space>ic",           -- close PR
      reopen_issue = "<space>io",          -- reopen PR
      list_issues = "<space>il",           -- list open issues on same repo
      reload = "<C-r>",                    -- reload PR
      open_in_browser = "<C-b>",           -- open PR in browser
      copy_url = "<C-y>",                  -- copy url to system clipboard
      add_assignee = "<space>aa",          -- add assignee
      remove_assignee = "<space>ad",       -- remove assignee
      create_label = "<space>lc",          -- create label
      add_label = "<space>la",             -- add label
      remove_label = "<space>ld",          -- remove label
      goto_issue = "<space>gi",            -- navigate to a local repo issue
      add_comment = "<space>ca",           -- add comment
      delete_comment = "<space>cd",        -- delete comment
      next_comment = "]c",                 -- go to next comment
      prev_comment = "[c",                 -- go to previous comment
      react_hooray = "<space>rp",          -- add/remove 🎉 reaction
      react_heart = "<space>rh",           -- add/remove ❤️ reaction
      react_eyes = "<space>re",            -- add/remove 👀 reaction
      react_thumbs_up = "<space>r+",       -- add/remove 👍 reaction
      react_thumbs_down = "<space>r-",     -- add/remove 👎 reaction
      react_rocket = "<space>rr",          -- add/remove 🚀 reaction
      react_laugh = "<space>rl",           -- add/remove 😄 reaction
      react_confused = "<space>rc",        -- add/remove 😕 reaction
    },
    review_thread = {
      goto_issue = "<space>gi",            -- navigate to a local repo issue
      add_comment = "<space>ca",           -- add comment
      add_suggestion = "<space>sa",        -- add suggestion
      delete_comment = "<space>cd",        -- delete comment
      next_comment = "]c",                 -- go to next comment
      prev_comment = "[c",                 -- go to previous comment
      select_next_entry = "]q",            -- move to previous changed file
      select_prev_entry = "[q",            -- move to next changed file
      close_review_tab = "<C-c>",          -- close review tab
      react_hooray = "<space>rp",          -- add/remove 🎉 reaction
      react_heart = "<space>rh",           -- add/remove ❤️ reaction
      react_eyes = "<space>re",            -- add/remove 👀 reaction
      react_thumbs_up = "<space>r+",       -- add/remove 👍 reaction
      react_thumbs_down = "<space>r-",     -- add/remove 👎 reaction
      react_rocket = "<space>rr",          -- add/remove 🚀 reaction
      react_laugh = "<space>rl",           -- add/remove 😄 reaction
      react_confused = "<space>rc",        -- add/remove 😕 reaction
    },
    submit_win = {
      approve_review = "<C-a>",            -- approve review
      comment_review = "<C-m>",            -- comment review
      request_changes = "<C-r>",           -- request changes review
      close_review_tab = "<C-c>",          -- close review tab
    },
    review_diff = {
      add_review_comment = "<space>ca",    -- add a new review comment
      add_review_suggestion = "<space>sa", -- add a new review suggestion
      focus_files = "<leader>e",           -- move focus to changed file panel
      toggle_files = "<leader>b",          -- hide/show changed files panel
      next_thread = "]t",                  -- move to next thread
      prev_thread = "[t",                  -- move to previous thread
      select_next_entry = "]q",            -- move to previous changed file
      select_prev_entry = "[q",            -- move to next changed file
      close_review_tab = "<C-c>",          -- close review tab
      toggle_viewed = "<leader><space>",   -- toggle viewer viewed state
    },
    file_panel = {
      next_entry = "j",                    -- move to next changed file
      prev_entry = "k",                    -- move to previous changed file
      select_entry = "<cr>",               -- show selected changed file diffs
      refresh_files = "R",                 -- refresh changed files panel
      focus_files = "<leader>e",           -- move focus to changed file panel
      toggle_files = "<leader>b",          -- hide/show changed files panel
      select_next_entry = "]q",            -- move to previous changed file
      select_prev_entry = "[q",            -- move to next changed file
      close_review_tab = "<C-c>",          -- close review tab
      toggle_viewed = "<leader><space>",   -- toggle viewer viewed state
    }
  }
})

-- Type :Vimrc to edit my personal vimrc files
vim.cmd('command! Vimrc :lua edit_my_vimrc()<CR>')
