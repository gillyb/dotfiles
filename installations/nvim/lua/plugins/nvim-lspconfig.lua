return {
  {
    "neovim/nvim-lspconfig",
    keys = {
      -- Disable <leader>cc mapping for lsp
      { "<leader>cc", false, mode = { "n", "x", "v" } },
    },
    init = function()
      local function uv_python()
        local python = vim.fn.getcwd() .. "/.venv/bin/python"
        if vim.fn.executable(python) == 1 then
          return python
        end
      end

      vim.lsp.config("ty", {
        filetypes = { "python", "py" },
        root_markers = { ".git", "uv.lock" },
        settings = {
          python = {
            pythonPath = uv_python(),
          },
        },
      })

      -- Required: Enable the language server
      vim.lsp.enable("ty")
    end,
    opts = function(_, opts)
      opts.autoformat = function()
        local filename = vim.api.nvim_buf_get_name(0)

        local in_ui_modules = string.find(filename, "/dev/ui-modules")
        if in_ui_modules ~= nil then
          return false
        end

        return true
      end

      return opts
    end,
  },
}
