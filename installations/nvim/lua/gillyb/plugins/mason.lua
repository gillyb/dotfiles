return {
  {
    "williamboman/mason.nvim",
    enable = false,
    version = "*",
    build = ":MasonUpdate",
    opts = {
      ui = {
        border = "rounded",
      },
    },
  },
  {
    "williamboman/mason-lspconfig.nvim",
    enable = false,
    version = "*",
    opts = { automatic_installation = true },
  },
}
