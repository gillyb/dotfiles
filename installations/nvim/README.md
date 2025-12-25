# Neovim Configuration

## LazyVim  

My configuration uses LazyVim which adds a ton of defaults.


## Random Info

Initial file to load is `config/lazy.nvim`.  
This loads and configures lazyvim.

After lazyvim loads its initial settings, it will load the other settings files 
inside the files `autocmds.lua`, `keymaps.lua` and `options.lua`.  




## Things to do

* Remove autocomplete for spelling (just regular words)  
* Remove autocomplete from comments
* Fix commenting to work with <leader>cc
* Make grep work on root_dir always
