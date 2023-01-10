-- escape key
vim.api.nvim_set_keymap('i', 'jk', '<esc>', { noremap=true })

-- Quick edit and reload of my .vimrc settings
vim.api.nvim_set_keymap('n', '<leader>ev', ':e $MYVIMRC<CR>', { noremap=false })
vim.api.nvim_set_keymap('n', '<leader>sv', ':so $MYVIMRC<CR>', { noremap=false })

-- Split current pane vertically
vim.api.nvim_set_keymap('n', '<leader>j', ':vsplit<CR>', { noremap=false, silent=true })
-- Split current pane horizontally
vim.api.nvim_set_keymap('n', '<leader>k', ':split<CR>', { noremap=false, silent=true })

-- Moving between splits
vim.keymap.set('n', '<C-J>', '<C-W><C-J>')
vim.keymap.set('n', '<C-K>', '<C-W><C-K>')
vim.api.nvim_set_keymap('n', '<C-L>', '<C-W><C-L>', { noremap=true })
vim.api.nvim_set_keymap('n', '<C-H>', '<C-W><C-H>', { noremap=true })

-- NerdTree specific
vim.api.nvim_set_keymap('n', '<C-n>', ':NERDTreeToggle<CR>', { noremap=false })
vim.api.nvim_set_keymap('n', '<leader>n', ':NERDTreeFind<CR>', { noremap=false })

-- Save and close windows
vim.api.nvim_set_keymap('n', '<leader>q', ':q<CR>', { noremap=true })
vim.api.nvim_set_keymap('n', '<leader>w', ':w<CR>', { noremap=true })

-- Hide search highlights
vim.api.nvim_set_keymap('n', '<C-f>', ':nohls<CR>', { noremap=true })

-- Modifies '{' and '}' keys so they don't save them in the jumplist
vim.api.nvim_set_keymap('n', '}', ':<C-u>execute "keepjumps norm! " . v:count1 . "}"<CR>', { noremap=true, silent=true })
vim.api.nvim_set_keymap('n', '{', ':<C-u>execute "keepjumps norm! " . v:count1 . "{"<CR>', { noremap=true, silent=true })

-- When deleting a single line or character don't paste it in the clipboard
-- NOTE: In order to delete a line and place in clipboard, you can use d_
vim.api.nvim_set_keymap('n', 'dd', '"_dd', { noremap=true })
vim.api.nvim_set_keymap('n', 'x', '"_x', { noremap=true })


-- lspsaga (Code actions)
vim.api.nvim_set_keymap('n', '<leader>rn', ':lua require("lspsaga.rename").rename()<CR>', {})
vim.api.nvim_set_keymap('n', '<leader>a', ':lua require("lspsaga.codeaction").code_action()<CR>', {})
vim.api.nvim_set_keymap('v', '<leader>a', ':lua require("lspsaga.codeaction").range_code_action()<CR>', {})


-- Completion
-- Use <Tab> and <S-Tab> to navigate through completion popup menu
vim.api.nvim_set_keymap('i', '<Tab>', 'pumvisible() ? "<C-n>" : "<Tab>"', { expr=true, noremap=true })
vim.api.nvim_set_keymap('i', '<S-Tab>', 'pumvisible() ? "<C-p>" : "<S-Tab>"', { expr=true, noremap=true })
-- Avoid showing message extra message when using completion
vim.cmd('set shortmess+=c')


-- Kommentary
vim.api.nvim_set_keymap('n', '<leader>cc', '<Plug>kommentary_line_default', {})
vim.api.nvim_set_keymap('x', '<leader>cc', '<Plug>kommentary_visual_default vv', {})

-- Grepper
-- vim.api.nvim_set_keymap('n', '<leader>gg', ':Grepper -tool rg -grepprg rg -H --no-heading --vimgrep --smart-case<CR>', { noremap=true })

-- Add undo 'breakpoints' when typing
vim.api.nvim_set_keymap('i', ',', ',<C-g>u', { noremap=true })
vim.api.nvim_set_keymap('i', '.', '.<C-g>u', { noremap=true })
vim.api.nvim_set_keymap('i', '!', '!<C-g>u', { noremap=true })
vim.api.nvim_set_keymap('i', '?', '?<C-g>u', { noremap=true })

-- Moving lines around
vim.keymap.set('v', '<C-J>', ":m '>+1<CR>gv")
vim.keymap.set('v', '<C-K>', ":m '<-2<CR>gv")
-- Tab to indent lines (or unindent)
-- vim.api.nvim_set_keymap('n', '<Tab>', '>>', { noremap=true })
-- vim.api.nvim_set_keymap('n', '<S-Tab>', '<<', { noremap=true })

-- Select previously pasted text
vim.api.nvim_set_keymap('n', 'gp', '`[v`]', { noremap=true })

-- Use 'zz' to place cursor at top third of window
_G.move_to_top_third = function()
  local window_lines = vim.fn.winheight(0)
  local one_sixth = math.floor(window_lines / 6)
  vim.cmd(':normal! zz')

  -- move the cursor down one-sixth of the screen
  vim.cmd(':normal! '..one_sixth..'j')

  -- recenter
  vim.cmd(':normal! zz')

  -- move cursor up one-sixth of the screen
  vim.cmd(':normal! '..one_sixth..'k')
end
vim.api.nvim_set_keymap('n', 'zz', ':lua move_to_top_third()<CR>', { noremap=true })

-- When searching for next/prev instance, always center the found word
vim.api.nvim_set_keymap('n', 'n', 'nzz', { noremap=true });
vim.api.nvim_set_keymap('n', 'N', 'Nzz', { noremap=true });
