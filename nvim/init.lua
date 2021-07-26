vim.g.mapleader = ';'

vim.o.compatible = false
vim.o.termguicolors = true
vim.o.mouse = 'a'
vim.o.bg = 'dark'
vim.o.fillchars = "vert:┃"
vim.o.encoding = 'UTF-8'
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
vim.cmd('colorscheme one')
vim.cmd('set background=dark')
vim.cmd('hi VertSplit guifg=grey')

-- Plugins
require'packer-bootstrap'
require'plugins'
require'keys'

-- airline
vim.g.airline_powerline_fonts = 1
vim.g.airline_skip_empty_sections = 1
vim.g.airline_section_x = ''
vim.g.airline_section_y = ''

-- indentLine
vim.g.indentLine_char = "⎸"
vim.api.nvim_command('autocmd Filetype json :IndentLinesDisable')
vim.api.nvim_command('autocmd BufNewFile json :IndentLinesDisable')
vim.api.nvim_command('autocmd BufEnter json :IndentLinesDisable')

-- NERDTree
vim.g.NERDTreeShowHidden = 1
vim.g.NERDTreeMinimalUI = 1
vim.g.NERDTreeStatusLine = ''
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
endfunction
autocmd BufReadPost quickfix silent call SetQuickFixMappings()
]])
