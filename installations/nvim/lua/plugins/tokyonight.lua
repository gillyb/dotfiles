return {
  "folke/tokyonight.nvim",
  enabled = false,
  lazy = false,
  opts = {
    style = "moon",
    on_colors = function(colors)
      colors.border = "#414141"
    end,
  },
}
