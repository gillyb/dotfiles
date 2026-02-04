-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "qf", -- Applies quickfix list buffers
--   callback = function()
--     -- Open file when pressing 'o'
--     vim.api.nvim_set_keymap("n", "o", "<CR>", { buffer = true, desc = "Open file" })
--   end,
-- })

-- Set .env files to be filetype=env
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { ".env" },
  callback = function()
    vim.bo.filetype = "env" -- Use vim.bo to set buffer-local option
  end,
  desc = "Set filetype to env for .env extensions",
})
