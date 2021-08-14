# Cheat Sheet  

Custom configurations I added/modified here.  
For general cheat sheet stuff, look at devhints.io

## nvim  

leader key: `;`  

### Shortcuts  

**Vim Configurations**  
`:Vimrc` - Telescope to vim configuration files  
`:PackerInstall` - Install / Uninstall plugins  
`:PackerUpdate` - Update plugins  

**Files**  
`Ctrl+p` - Open telescope file finder  
`<leader>bb` - Open telescope for open buffers  
`<leader>n` - Find file in nerd tree  
`<leader>w` - Save file  

**Code (lsp)**  
`gd` - Go to definition  
`gD` - Go to declaration  
`gi` - Go to implementation  
`gr` - Find references  
`K` - Hover info  
`[d` - Next diagnostic message  
`]d` - Previous diagnostic message  
`<leader>gk` - Signature help  
`<leader>rn` - Rename (under cursor)  
`<leader>a` - Code actions  

`<leader>cc` - Comment/Uncomment line  

**Splits**  
`<leader>j` - Split current pane vertically  
`<leader>k` - Split current pane horizontally  
`:vertical resize +10` - Move vertical split   
`:resize +10` - Move horizontal split  

**Editing**  
`ciw` - Change inner word  
`diw` - Delete inner word  
`u` - Undo last change  
`r` - Redo change  

**Find / Replace**  
`/` - Search for text  
`Ctrl+f` - Remove highlights  
`n`/`p` - Next/Previous occurence  
`:s/<original_word>/<replace_word>/` - find replace


## tmux  

leader key: `Ctrl+a`  

`<leader>j` - Split vertically  
`<leader>k` - Split horizontally  

`<leader>d` - Detach session  
`tmux ls` - List running sessions  
`tmux a -t <session_name>` - Attach to session  

`<leader>c` - New tab  
`<leader>n` - Next tab  
`<leader>p` - Previous tab  

`<leader>x` - Close pane/window/tab  
