return {
   -- Fuzzy Finder (files, lsp, etc)
  {
    'nvim-telescope/telescope.nvim',
    version = '*',
    dependencies = {
      'nvim-lua/plenary.nvim',
      "nvim-telescope/telescope-live-grep-args.nvim" ,
        -- This will not install any breaking changes.
        -- For major updates, this must be adjusted manually.
        version = "^1.0.0",
    },
    config = function()
      require("telescope").load_extension("live_grep_args")
    end
  },
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    -- NOTE: If you are having trouble with this installation,
    --       refer to the README for telescope-fzf-native for more instructions.
    build = 'make',
    cond = function()
      return vim.fn.executable 'make' == 1
    end,
  },
}






-- return {
  -- {
    -- 'telescope.nvim',
    -- dependencies = {
      -- 'nvim-telescope/telescope-fzf-native.nvim',
      -- build = 'make',
      -- config = function()
        -- require('telescope').load_extension('fzf')
      -- end,
    -- },
    -- keys = {
      -- {
        -- '<C-p>',
        -- function()
          -- require('telescope.builtin').find_files({
            -- cwd = require('lazy.core.config').options.root,
          -- })
        -- end
      -- }
    -- },
    -- opts = {
      -- defaults = {
        -- file_sorter = require('telescope.sorters').get_fzy_sorter,
        -- generic_sorter = require('telescope.sorters').get_fzy_sorter,
        -- layout_strategy = 'horizontal',
        -- theme = 'dropdown',
        -- layout_config = { prompt_position = 'top' },
        -- sorting_strategy = 'ascending',
        -- winblend = 0,
      -- },
    -- },
  -- },
-- }
