return {
  "folke/tokyonight.nvim",
  enabled = true,
  lazy = false,
  opts = {
    style = "moon",
    on_colors = function(colors)
      colors.border = "#414141"
    end,
  },
}
