return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,

    ---@type snacks.Config
    keys = {
      {
        "<C-p>", -- Ctrl+p to open file picker
        function()
          Snacks.picker.files()
        end,
        desc = "Open file picker",
      },
      {
        "<leader>bb",
        function()
          Snacks.picker.buffers()
        end,
        desc = "Open buffers",
      },
      {
        "<leader>n",
        function()
          local explorer = Snacks.explorer.reveal()
          if explorer then
            explorer:focus()
          end
        end,
        desc = "Find current file in explorer",
      },
    },

    opts = {
      explorer = {
        replace_netrw = true,
        follow_file = false,
        hidden = true,
      },

      picker = {
        sources = {
          explorer = {
            hidden = true,
            follow_file = false, -- don't auto-jump to the current buffer
            win = {
              list = {
                keys = {
                  ["s"] = "explorer_open", -- open system editor
                  ["o"] = "confirm", -- open in nvim buffer
                },
              },
            },
          },
        },
      },

      -- Highlights the word under the cursor and it's usages (from LSP)
      words = { enabled = true },
    },
  },
}
