return {
  "nvimdev/lspsaga.nvim",
  event = "LspAttach",
  config = function()
    require("lspsaga").setup({
      -- Dont show breadcrumbs in winbar for each file
      symbol_in_winbar = {
        enable = false
      },
      outline = {
        layout = 'float',
        auto_preview = false
      }
    })
  end,
  dependencies = {
    { "nvim-tree/nvim-web-devicons" },
    --Please make sure you install markdown and markdown_inline parser
    { "nvim-treesitter/nvim-treesitter" }
  }
}
