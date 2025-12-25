# Neovim Configuration

## LazyVim  

My configuration uses LazyVim which adds a ton of defaults.


## Random Info

Initial file to load is `config/lazy.nvim`.  
This loads and configures lazyvim.

After lazyvim loads its initial settings, it will load the other settings files 
inside the files `autocmds.lua`, `keymaps.lua` and `options.lua`.  

All files in the `/plugins` folder will be loaded as well.  
Each plugin file returns a lua table.  
The first value is the name of the plugin.  
The rest of the values are settings specific to that plugin.  

You can disable a plugin by adding `enabled = false` to the returned table.  
The `opts = {}` parameter is for adding everything that would be added inside a plugins `setup({})` method.




## Things to do (or find out how to do)

* Remove autocomplete for spelling (just regular words)  
* Remove autocomplete from comments
* Fix commenting to work with <leader>cc
* Make grep work on root_dir always  
* Find file in file explorer  
* Visually select code block, and expand selection
* Go to top of code block
* Keymap for selecting buffer with <leader>bb
