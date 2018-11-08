set termguicolors

" Set tabs to two spaces
filetype plugin indent on
set tabstop=2
set shiftwidth=2
set laststatus=2
set expandtab

set splitright
set nowrap
set cursorline

set ignorecase
set smartcase
set number relativenumber
set ruler

set fillchars=                 " set fillchars=vert:\|,fold:-
set colorcolumn=+0
set wrapscan

set pastetoggle=<leader>p
set hidden  " This allows us to change buffers even if we have unsaved changes

" Automatically reload a file if it was edited outside of vim
set autoread

" PLUGINS (using vim-plug to install plugins) "
call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdtree', { 'on': ['NERDTree', 'NERDTreeToggle', 'NERDTreeFocus', 'NERDTreeFind'] }
Plug 'scrooloose/nerdcommenter'
Plug 'rakr/vim-one'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'leafgarland/typescript-vim'
Plug 'ternjs/tern_for_vim', { 'do': 'npm install' }

" Filetype specific plugins
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }

" Only compatible with neovim
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' } " Auto-Completion
  Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern' }
  Plug 'mhartington/nvim-typescript'
else
  " The extra plugins are required if we're not using neovim
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif

" Deoplete plugin settings
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_ignore_case = 1
let g:deoplete#enable_smart_case = 1
let g:deoplete#auto_complete_start_length = 1
" This adds autocompletion when hitting the 'tab' key
inoremap <expr><tab> pumvisible() ? "\<C-n>" : "\<tab>"
autocmd FileType javascript nnoremap <silent> <buffer> gb :TernDef<CR>


call plug#end()
" PLUGINS EOF

" If NERDTree is the only thing opened, then close vim
" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif



" KEY BINDINGS "
inoremap jk <esc>
let mapleader = ';'	" set 'leader' key to be '.' (instead of the default '\')

" Split the current screen vertically
map <leader>j :vsplit<CR>
" Split the screen horizontally
map <leader>k :split<CR>

" These 4 lines redefine the shortcuts for moving between splits
nnoremap <C-J> <C-W><C-J>	
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

map <C-n> :NERDTreeToggle<CR>
map <leader>n :NERDTreeFind<CR>
map <leader>qq :q<CR>
map <leader>ww :w<CR>
let g:NERDTreeWinSize=41

" Open nerdtree automatically if no file was specified (we opened a dir)
function! StartUp()
  if 0 == argc()
    NERDTree
  end
endfunction
autocmd VimEnter * call StartUp()

" NerdCommenter
let g:NERDCreateDefaultMappings = 0
noremap <leader>cc :call NERDComment(0, "toggle")<CR>


" Go to next buffer (tab)
map <leader>f :bn<CR>
" Go to previous buffer (tab)
map <leader>d :bp<CR>

" hide the search highlights
map <C-f> :nohls<CR>


" Search for files in the current dir (using fzf and fd)
map <C-o> :Files<CR>

" COLORS "
colorscheme one
set background=dark
let g:one_allow_italics=1
" call one#highlight('Normal', '', '1a1a1a', '')
call one#highlight('Folded', '555555', '111111', '')
call one#highlight('VertSplit', '', '5c6370', 'none')
"call one#highlight('StatusLine', '', '5c6370', 'none')
"call one#highlight('StatusLineNC', '', '5c6370', 'none')


set statusline=
set statusline+=%f " Path to the file in the buffer, as typed or relative to current directory
set statusline+=%< " Where to truncate line
set statusline+=%{&modified?'\ +':''}
set statusline+=%{&readonly?'\ ':''}
set statusline+=%= " Separation point between left and right aligned items
" set statusline+=%{gutentags#statusline()}
set statusline+=\ [%{''!=#&filetype?&filetype:'none'}]
set statusline+=\ %l:%v " Line number + column number


" Extra stuff "
set nocompatible	" Turn off vi compatibility mode
syntax on		" syntax highlighting


" Colors that define split borders and status line
hi clear VertSplit
hi VertSplit guibg=grey
hi StatusLine guibg=grey guifg=black
hi StatusLineNC guibg=grey guifg=grey
