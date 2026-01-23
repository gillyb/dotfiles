return {
  {
    "saghen/blink.cmp",
    enabled = true,
    opts = {
      sources = {
        default = function()
          return { "lsp", "path" }
        end,
      },
    },
  },
}
