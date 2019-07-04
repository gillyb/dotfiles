set termguicolors
set mouse=a
set nocompatible	" Turn off vi compatibility mode
syntax on		" syntax highlighting
set encoding=UTF-8

" Set tabs to two spaces filetype plugin indent on
filetype plugin on
set tabstop=2
set shiftwidth=2
set laststatus=2
set expandtab
set autoindent
set smartindent

set showmatch     " Show matching brackets when text indicator is over them

" Automatically reload a file if it was edited outside of vim
set autoread
 
set scrolloff=3   " Always leave 3 lines of context on the screen
set sidescrolloff=5  " Show 5 chars when scrolling horizontally
set showcmd       " Show typed commands

set splitright
set nowrap
set cursorline    " highlight the current cursor line

set ignorecase
set smartcase
set incsearch     " Highlight matches while typing search term


" Show line numbers relative to the selected line
set number relativenumber
set ruler

set cmdheight=2       " height of command view under status line
set pumheight=10      " maximum height of autocomplete menu
set updatetime=300
set completeopt=longest,menuone  " This will select longest match in autocomplete menu
                                 " and also open the menu even if there's a
                                 " single option.

"set listchars=tab:>\G,trail:-,extends:>,precedes:<,nbsp:+


"set fillchars=vert:\|,fold:-

"set colorcolumn=+0
"set wrapscan

set nobackup
set noswapfile

set pastetoggle=<leader>p
set hidden  " This allows us to change buffers even if we have unsaved changes



"""
""" PLUGINS
"""

" PLUGINS (using vim-plug to install plugins) "
call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdtree', { 'on': ['NERDTree', 'NERDTreeToggle', 'NERDTreeFocus', 'NERDTreeFind'] }    " Filetree
Plug 'scrooloose/nerdcommenter'    " Easily comment code Plug 'joshdick/onedark.vim'
Plug 'tpope/vim-fugitive' " git integration
Plug 'vim-airline/vim-airline'   " Nicer status line
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }    " fuzzy find for file system
Plug 'junegunn/fzf.vim'
Plug 'mileszs/ack.vim'    " Cool searching
Plug 'mattn/emmet-vim'    " Easily create html tags
Plug 'leafgarland/typescript-vim'   " typescript syntax highlighting
Plug 'Yggdroot/indentLine'

Plug 'neoclide/coc.nvim', {'tag': '*', 'do': './install.sh'}

call plug#end()
" PLUGINS EOF

let g:airline#extensions#branch#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_skip_empty_sections = 1
let g:airline_section_x = ''    " Hide the file-type in the status bar
let g:airline_section_y = ''    " Hide the file-encoding in the status bar

let g:indentLine_char = "⎸"     " Show a continuous line for indentations
autocmd Filetype json :IndentLinesDisable      " Disable the indentLine plugin in json files because of some bug


" Use the_silver_searcher for ack.vim (when searching directories)
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif




" If NERDTree is the only thing opened, then close vim
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" Show hidden files in nerdtree
let NERDTreeShowHidden=1



"""
""" KEY BINDINGS
"""

nmap <C-d> 1g;

" set 'jk' to be 'esc' key too
inoremap jk <esc>
" Set 'leader' key to ';'
let mapleader = ';'

" Auto complete brackets with closing bracket
" This only works when typing an opening bracket 
" and immediately 'enter' after.
inoremap {<CR>  {<CR>}<Esc>O
inoremap (<CR>  (<CR>)<Esc>O
inoremap [<CR>  [<CR>]<Esc>O

" Quick edit and reload of .vimrc settings
nmap <leader>ev :e $MYVIMRC<CR>
nmap <leader>sv :so $MYVIMRC<CR>

" To split the current screen vertically
map <leader>j :vsplit<CR>
" For horizontal split
map <leader>k :split<CR>

" These 4 lines redefine the shortcuts for moving between splits
" Ctrl + H: moves you to the split on your left
" Ctrl + L: moves you to the split on your right
" Ctrl + J: moves you to the split below you
" Ctrl + K: moves you to the split above you
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" When the autocomplete menu is open, use Ctrl+J/K to move up/down
inoremap <expr> <C-J> pumvisible() ? "\<Down>" : "\<C-W><C-J>"
inoremap <expr> <C-K> pumvisible() ? "\<Up>" : "\<C-W><C-K>"

map <C-n> :NERDTreeToggle<CR>
map <leader>n :NERDTreeFind<CR>
map <leader>qq :q<CR>
map <leader>ww :w<CR>
let g:NERDTreeWinSize=31


" Open nerdtree by default when nvim was opened without any file
function! StartUp()
  if 0 == argc()
    NERDTree
  end
endfunction
autocmd VimEnter * call StartUp()

" NerdCommenter
" ;+cc to toggle comments on selected lines
let g:NERDCreateDefaultMappings = 0
noremap <leader>cc :call NERDComment(0, "toggle")<CR>

" Go to next buffer (tab)
map <leader>f :bn<CR>
" Go to previous buffer (tab)
map <leader>d :bp<CR>

" Ctrl + f: hide the search highlights
map <C-f> :nohls<CR>

" Navigate forward and back through the jump list
" with '[[' (back) and ']]' (forward)
" Only in normal mode
nnoremap [[ <C-O>
nnoremap ]] <C-I>

" This modifies '{' and '}' actions not to save them in the jumplist
nnoremap } :<C-u>execute "keepjumps norm! " . v:count1 . "}"<CR>
nnoremap { :<C-u>execute "keepjumps norm! " . v:count1 . "{"<CR>

" When deleting a line, don't save it to the clipboard
" explanation: 'dd' deletes a full line, but also puts it on the clipboard.
"              "_dd is how you can delete a line without copying it to the
"              clipboard
nnoremap dd "_dd

" Ctrl + o: Search for files in the current dir (using fzf and fd)
nmap <C-o> :Files<CR>



"""
""" COLORS (and fonts)
"""
let g:onedark_terminal_italics=1
"colorscheme onedark
colorscheme darcula



"" Colors that define split borders and status line
"hi clear VertSplit
hi VertSplit guifg=grey


" Specific to coc.vim (language server)
autocmd FileType json syntax match Comment +\/\/.\+$+    " Colors comments correctly on json files
" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

autocmd FileType typescript let b:coc_root_patterns = ['.git']
autocmd FileType javascript let b:coc_root_patterns = ['.git']

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <C-p> coc#refresh()
" Use Ctrl+U for 'go to definition'
nmap <silent> <C-u> <Plug>(coc-definition)

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

