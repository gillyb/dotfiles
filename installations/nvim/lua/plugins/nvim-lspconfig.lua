return {
  {
    "neovim/nvim-lspconfig",
    opts = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()

      -- Disable <leader>cc mapping for lsp
      keys[#keys + 1] = { mode = { "n", "x", "v" }, "<leader>cc", false }
    end,
  },
}
