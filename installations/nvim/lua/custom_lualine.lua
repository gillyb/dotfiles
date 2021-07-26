-- This is supposed to show the status of the lsp loading
-- but for some reason doesn't really work.
-- Copied from: https://github.com/folke/dot/blob/master/config/nvim/lua/config/lualine.lua
local function lsp_progress()
  local messages = vim.lsp.util.get_progress_messages()
  if #messages == 0 then
    return
  end
  local status = {}
  for _, msg in pairs(messages) do
    table.insert(status, (msg.percentage or 0) .. "%% " .. (msg.title or ""))
  end
  local spinners = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
  local ms = vim.loop.hrtime() / 1000000
  local frame = math.floor(ms / 120) % #spinners
  return table.concat(status, " | ") .. " " .. spinners[frame + 1]
end


-- vim.cmd([[autocmd User LspProgressUpdate let &ro = &ro]])
vim.cmd([[autocmd User LspProgressUpdate echom 'lsp update']])

-- Configure my statusline (hoob3rt/lualine)
require('lualine').setup({
  options = {
    icons_enabled = true,
    theme = 'onedark',
    section_separators = { "", "" },
    component_separators = { "", "" },
    disabled_filetypes = {'nerdtree'}
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = { 
      { 
        'diagnostics', 
        sources = { 'nvim_lsp' }
      }
    },
    lualine_c = {lsp_progress, 'filename'},
    lualine_x = {},
    lualine_y = {'encoding'},
    -- I just want to see line number out of total lines and col, I don't care about percentage
    lualine_z = { '[[%l/%L :%c]]' },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {
      {
        'diagnostics',
        sources = { 'nvim_lsp' }
      }
    },
    lualine_c = {'filename'},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {'nvim-tree'}
})
