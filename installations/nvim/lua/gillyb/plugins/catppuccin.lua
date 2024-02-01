return {
  -- My color scheme
  "catppuccin/nvim",
  lazy = false,
  name = "catppuccin",
  priority = 1000,
  init = function ()
    vim.cmd.colorscheme('catppuccin')
  end,
  opts = {
    flavour = 'frappe',
    show_end_of_buffer = false,
    dim_inactive = {
      enabled = true,
      shade = 'dark',
      percentage = 0.15
    },
    no_italic = false,
    no_bold = false,
    styles = {
      comments = { 'italic' }
    },
    integrations = {
      cmp = true,
      gitsigns = true,
      nvimtree = true,
      treesitter = true,
      treesitter_context = true,
      telescope = true,
      mason = true,
      lsp_saga = true,
      fidget = true,
      native_lsp = {
        enabled = true
      }
    }
  }
}
