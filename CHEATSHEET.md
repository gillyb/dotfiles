# Cheat Sheet  

Custom configurations I added/modified here.  
For general cheat sheet stuff, look at devhints.io

## nvim  

leader key: `;`  

### Shortcuts  

**Vim Configurations**  

In the terminal type `dotfiles` to go to the dotfiles directory, and hit `v` to open neovim.  

Inside neovim:  
* type `:Lazy` to see which plugins are installed and enabled
* type `:Mason` to see which language servers are installed


**Files**  
`Ctrl+p` - Open file finder  
`<leader>bb` - Open buffers list  
`<leader>n` - Find file in file explorer
`<leader>w` - Save file  
`<leader>q` - Close buffer (file)

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

`za` - Fold/Unfold code section  

**Splits**  
`<leader>j` - Split current pane vertically  
`<leader>k` - Split current pane horizontally  
`:vertical resize +10` - Move vertical split   
`:resize +10` - Move horizontal split  

**Editing**  
`ciw` - Change inner word  
`diw` - Delete inner word  
`ci(` - Change inside parenthesis
`ci<` - Change inside brackets
`u` - Undo last change  
`r` - Redo change  

**Find / Replace**  
`/` - Search for text  
`Ctrl+f` - Remove highlights  
`n`/`p` - Next/Previous occurence  
`:s/<original_word>/<replace_word>/` - find replace

**Lsp**  
`:LspInfo` - Get lsp status of active language servers  
`:LsRestart` - Restarts the language server  

Misc  
`<C-/>` - Opens (or closes) a terminal buffer

Quickfix List  
`<C-q>` - Open the quickfix list with the current list in it
`Cfilter <query>` - filter the quickfix list to only entries with `query` in them.
`Cfilter !<query>` - filter **out** the entries with `query` in them.


## tmux  

leader key: `Ctrl+a`  

`<leader>j` - Split vertically  
`<leader>k` - Split horizontally  

`<leader>d` - Detach session  
`tmux ls` - List running sessions  
`tmux a -t <session_name>` - Attach to session  
`tmux new -t <session_name>` - Create new session with given name  

`<leader>c` - New tab  
`<leader>n` - Next tab  
`<leader>p` - Previous tab  

`<leader>x` - Close pane/window/tab  


## Git stuff

Checkout file from another branch: `git checkout <branch> -- <file>`  

