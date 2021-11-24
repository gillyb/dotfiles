vim.g.mapleader = ';'

vim.o.compatible = false
vim.o.termguicolors = true
vim.o.mouse = 'a'
vim.o.bg = 'dark'
vim.o.fillchars = "vert:┃"
vim.o.encoding = 'utf-8'
vim.o.clipboard = 'unnamed'
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.laststatus = 2
vim.o.autoindent = true
vim.o.expandtab = true
vim.o.smartindent = true
vim.o.showmatch = true
vim.o.autoread = true
vim.o.scrolloff = 3
vim.o.sidescrolloff = 5
vim.o.showcmd = true
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.wrap = false
vim.o.cursorline = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.incsearch = true
vim.o.number = true
vim.o.cmdheight = 2
vim.o.pumheight = 11
vim.o.updatetime = 300
vim.o.completeopt = 'menuone,noinsert,noselect'
vim.g.completion_matching_strategy_list = { 'exact', 'substring', 'fuzzy' }
vim.o.backup = false
vim.o.swapfile = false
vim.o.hidden = true
vim.cmd('syntax on')

-- Don't use kommentary's default mappings
vim.g.kommentary_create_default_mappings = false

-- Set color scheme
--- Example config in Lua
vim.g.sonokai_style = 'andromeda'
vim.g.tokyonight_dev = true
vim.g.nvcode_termcolors = true
vim.g.tokyonight_style = "storm"
vim.g.tokyonight_italic_functions = true
vim.g.tokyonight_sidebars = { "qf", "vista_kind", "terminal", "packer" }
-- Change the "hint" color to the "orange" color, and make the "error" color bright red
vim.g.tokyonight_colors = { hint = "orange", error = "#ff0000" }

vim.o.background = 'dark'
-- require('onedarkpro').load()
vim.cmd('colorscheme one')
-- vim.cmd('colorscheme darcula')
-- vim.cmd('colorscheme sonokai')
-- vim.cmd('colorscheme tokyonight')
vim.cmd('hi VertSplit guifg=grey')


-- Plugins
require'packer-bootstrap'
require'plugins'
require'keys'

-- indentLine
vim.g.indentLine_char = "⎜"
vim.g.indentLine_color_term = 239
vim.api.nvim_command('autocmd Filetype json :IndentLinesDisable')
vim.api.nvim_command('autocmd BufNewFile json :IndentLinesDisable')
vim.api.nvim_command('autocmd BufEnter json :IndentLinesDisable')

-- NERDTree
vim.g.NERDTreeShowHidden = 1
vim.g.NERDTreeMinimalUI = 1
vim.g.NERDTreeStatusLine = ''
vim.g.NERDTreeWinSize = 40
vim.cmd("let g:NERDTreeIgnore = ['^\\.DS_Store', '\\.git$[[dir]]', '\\.idea$[[dir]]']")
-- Open NERDTree immediately when opening vim
vim.cmd([[
function! StartUp()
  if 0 == argc()
    NERDTree
  end
endfunction
autocmd VimEnter * call StartUp()
]])

-- Quickfix lists
vim.cmd([[
function! SetQuickFixMappings()
  " Use 'o' to open the file the cursor is on
  nnoremap <buffer> <silent> o <CR>
  " Use 'q' to close the quickfix window
  nnoremap <buffer> <silent> q :q<CR>
  " Set quickfix height to 15
  resize 15
endfunction
autocmd BufReadPost quickfix silent call SetQuickFixMappings()
]])

-- Don't show cursor line in inactive windows
vim.cmd([[
  autocmd InsertLeave,WinEnter * set cursorline
  autocmd InsertEnter,WinLeave * set nocursorline
]])


-- Always open quickfix window in full width
vim.cmd([[
  autocmd FileType qf if (getwininfo(win_getid())[0].loclist != 1) | wincmd J | endif
]])
