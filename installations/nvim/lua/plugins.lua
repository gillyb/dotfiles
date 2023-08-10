require('lazy').setup({

  -- NERDTree file explorer
  'scrooloose/nerdtree',

  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',

  --[[ { -- My color scheme
    'sainnhe/edge',
    priority = 1000,
    config = function()
      vim.cmd.colorscheme('edge')
      vim.cmd('highlight VertSplit cterm=None')
      vim.cmd('highlight WinSeparator cterm=None')
    end
  }, ]]
  { -- Current color scheme
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000
  },

  -- mhinz/vim-grepper

  { -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help indent_blankline.txt`
    opts = {
      char = '┊',
      show_trailing_blankline_indent = false,
    },
  },

  -- NOTE: This is where your plugins related to LSP can be installed.
  --  The configuration is done below. Search for lspconfig to find it below.
  { -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',

      -- Useful status updates for LSP
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { 'j-hui/fidget.nvim', opts = {} },

      -- Additional lua configuration, makes nvim stuff amazing!
      'folke/neodev.nvim',
    },
  },

  { -- Autocompletion
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip'
    },
  },

  {
    "glepnir/lspsaga.nvim",
    event = "BufRead",
    config = function()
      require("lspsaga").setup({})
    end,
    dependencies = {
      { "nvim-tree/nvim-web-devicons" },
      --Please make sure you install markdown and markdown_inline parser
      { "nvim-treesitter/nvim-treesitter" }
    }
  },

  {
    'nvim-lualine/lualine.nvim',
    -- See `:help lualine.txt`
    opts = {
      options = {
        icons_enabled = false,
        -- theme = 'edge',
        component_separators = '|',
        section_separators = '',
      },
    },
  },

  { -- Fuzzy Finder (files, lsp, etc)
    'nvim-telescope/telescope.nvim',
    version = '*',
    dependencies = { 'nvim-lua/plenary.nvim' }
  },

  -- Fuzzy Finder Algorithm which requires local dependencies to be built.
  -- Only load if `make` is available. Make sure you have the system
  -- requirements installed.
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    -- NOTE: If you are having trouble with this installation,
    --       refer to the README for telescope-fzf-native for more instructions.
    build = 'make',
    cond = function()
      return vim.fn.executable 'make' == 1
    end,
  },

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

  'b3nj5m1n/kommentary', -- Easy commenting/uncommenting

  'tpope/vim-fugitive',  -- git actions
  {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup()
    end
  },

  'dylon/vim-antlr',                 -- lsp plugin for ANTLR

  'alexghergh/nvim-tmux-navigation', -- nvim <--> tmux navigation

  {
    'windwp/nvim-autopairs',
    opts = {
      check_ts = true
    }
  },

  { 'elentok/format-on-save.nvim' }

})

-- TODO: Extract this to separate file
local format_on_save = require("format-on-save")
local formatters = require("format-on-save.formatters")

format_on_save.setup({
  exclude_path_patterns = {
    "/node_modules/",
    ".local/share/nvim/lazy",
  },
  formatter_by_ft = {
    css = formatters.lsp,
    html = formatters.lsp,
    java = formatters.lsp,
    javascript = formatters.lsp,
    json = formatters.lsp,
    lua = formatters.lsp,
    -- markdown = formatters.prettierd,
    openscad = formatters.lsp,
    rust = formatters.lsp,
    scad = formatters.lsp,
    scss = formatters.lsp,
    sh = formatters.shfmt,
    terraform = formatters.lsp,
    typescriptreact = formatters.prettierd,
    yaml = formatters.lsp,

    --[[ typescript = {
      formatters.prettierd
    }, ]]

    -- Add your own shell formatters:
    myfiletype = formatters.shell({ cmd = { "myformatter", "%" } }),

    -- Add lazy formatter that will only run when formatting:
    my_custom_formatter = function()
      if vim.api.nvim_buf_get_name(0):match("/README.md$") then
        return formatters.prettierd
      else
        return formatters.lsp()
      end
    end,

    -- -- Add custom formatter
    filetype1 = formatters.remove_trailing_whitespace,
    filetype2 = formatters.custom({
      format = function(lines)
        return vim.tbl_map(function(line)
          return line:gsub("true", "false")
        end, lines)
      end
    }),

    -- Concatenate formatters
    python = {
      formatters.remove_trailing_whitespace,
      formatters.shell({ cmd = "tidy-imports" }),
      formatters.black,
    },

    -- Use a tempfile instead of stdin
    go = {
      formatters.shell({
        cmd = { "goimports-reviser", "-rm-unused", "-set-alias", "-format", "%" },
        tempfile = function()
          return vim.fn.expand("%") .. '.formatter-temp'
        end
      }),
      formatters.shell({ cmd = { "gofmt" } }),
    },
  },
})

-- Color scheme setup
require('catppuccin').setup({
  flavour = 'frappe',
  show_end_of_buffer = false,
  dim_inactive = {
    enabled = true,
    shade = 'dark',
    percentage = 0.15
  },
  no_italic = false,
  no_bold = false,
  styles = {
    comments = { 'italic' }
  },
  integrations = {
    cmp = true,
    gitsigns = true,
    nvimtree = true,
    treesitter = true
  }
})
vim.cmd.colorscheme('catppuccin')



-- Snippets --
-- TODO: Move this to separate file
local ls = require('luasnip');
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require("luasnip.util.events")
local ai = require("luasnip.nodes.absolute_indexer")
local extras = require("luasnip.extras")
local l = extras.lambda
local rep = extras.rep
local p = extras.partial
local m = extras.match
local n = extras.nonempty
local dl = extras.dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local conds = require("luasnip.extras.expand_conditions")
local postfix = require("luasnip.extras.postfix").postfix
local types = require("luasnip.util.types")
local parse = require("luasnip.util.parser").parse_snippet
local ms = ls.multi_snippet

ls.add_snippets('javascript', {
  -- 'd' to create an empty <div>
  s('d', {
    t('<div className="">'),
    i(0),
    t('</div>')
  }),

  -- 'us' to add useState
  s('us', {
    t('const ['), i(1), t(', set'), i(1), t('] = useState('), i(2), t(');')
  }),
  -- 'fc' for 'function component'
  s('fc', {
    t('import {useState} from \'react\';\n\nexport default function '),
    i(1),
    t('(props) {\n\nreturn (\n\n\n);\n}')
  })
})
