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
    },
    opts = {
      picker = {
        sources = {
          explorer = {
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
    },
  },
}
