
-- To check what a key is mapped to, inside vim type ':imap _key_'

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
-- TODO: Move these to lsp-config
vim.api.nvim_set_keymap('n', '<leader>rn', '<cmd>Lspsaga rename<CR>', {})
vim.api.nvim_set_keymap('n', '<leader>a', '<cmd>Lspsaga code_action<CR>', {})


-- Completion
-- Use <Tab> and <S-Tab> to navigate through completion popup menu
-- vim.api.nvim_set_keymap('i', '<Tab>', 'pumvisible() ? "<C-n>" : "<Tab>"', { expr=true, noremap=true })
-- vim.api.nvim_set_keymap('i', '<S-Tab>', 'pumvisible() ? "<C-p>" : "<S-Tab>"', { expr=true, noremap=true })
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

-- Navigate between tmux and nvim windows easily
local nvim_tmux_nav = require('nvim-tmux-navigation')
vim.keymap.set('n', "<C-h>", nvim_tmux_nav.NvimTmuxNavigateLeft)
vim.keymap.set('n', "<C-j>", nvim_tmux_nav.NvimTmuxNavigateDown)
vim.keymap.set('n', "<C-k>", nvim_tmux_nav.NvimTmuxNavigateUp)
vim.keymap.set('n', "<C-l>", nvim_tmux_nav.NvimTmuxNavigateRight)
vim.keymap.set('n', "<C-\\>", nvim_tmux_nav.NvimTmuxNavigateLastActive)
vim.keymap.set('n', "<C-Space>", nvim_tmux_nav.NvimTmuxNavigateNext)






-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)

    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'gp', '<cmd>Lspsaga peek_definition<CR>', opts)
    vim.keymap.set('n', 'go', '<cmd>Lspsaga outline<CR>', opts)

    vim.keymap.set('n', '<space>ic', '<cmd>Lspsaga incoming_calls<CR>', opts)
    vim.keymap.set('n', '<space>oc', '<cmd>Lspsaga outgoing_calls<CR>', opts)

    vim.keymap.set('n', 'K', '<cmd>Lspsaga hover_doc<CR>', opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    -- vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<space>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)

    vim.keymap.set('n', '[d', vim.diagnostic.goto_next, opts)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_prev, opts)

    vim.keymap.set('n', '[e', function()
      vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })
    end, opts)
    vim.keymap.set('n', ']e', function()
      vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR })
    end, opts)

  end,
})

