return {
  {
    "saghen/blink.cmp",
    enabled = true,
    version = "1.*",
    opts = {
      sources = {
        default = function()
          return { "lsp", "path" }
        end,
      },
    },
  },
}
