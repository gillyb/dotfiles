""" COLORS """
syntax enable
set background=dark
let g:solarized_termcolors=256
colorscheme solarized		" color scheme is saved in ~/.vim/colors/

""" SPACES & TABS """
set tabstop=4			" number of visual spaces per tab
set softtabstop=4		" number of spaces in tab when editing
set expandtab			" tabs are spaces

""" UI SETTINGS """
set number			" show line numbers
set showcmd			" show command in bottom bar
set cursorline			" highlight current line
set wildmenu			" autocompletion in the command line
set lazyredraw			" only redraw the screen when needed
set showmatch			" highlight matching brackets
" search "
set incsearch			" search as characters are entered
set hlsearch			" highlight search matches

inoremap jk <esc>       " This maps 'jk' as the escape sequence (instead of hitting <esc>)


""" PLUGINS """
" ctrlp.vim - http://ctrlpvim.github.io/ctrlp.vim
" type ':help ctrlp.txt' inside vim to get help
set runtimepath^=~/.vim/bundle/ctrlp.vim        " Sets 'ctrlp.vim' plugin directory
let g:ctrlp_match_window = 'bottom,order:ttb'
let g:ctrlp_switch_buffer = 0
let g:ctrlp_working_path_mode = 0
let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'
let g:ctrlp_working_path_mode = 'ra'

" ag " - https://github.com/rking/ag.vim
" type ':help ag' inside vim to get help
set runtimepath^=~/.vim/bundle/ag
