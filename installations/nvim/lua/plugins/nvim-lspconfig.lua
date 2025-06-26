return {
  {
    "neovim/nvim-lspconfig",
    init = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()

      -- Disable <leader>cc mapping for lsp
      keys[#keys + 1] = { mode = { "n", "x", "v" }, "<leader>cc", false }
    end,
    opts = {
      autoformat = function()
        local filename = vim.api.nvim_buf_get_name(0)

        local in_ui_modules = string.find(filename, "/dev/ui-modules")
        if in_ui_modules ~= nil then
          return false
        end

        return true
      end,
    },
  },
}
