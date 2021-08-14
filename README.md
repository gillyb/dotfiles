# dotfiles
A repo for all my settings (dot) files, and some cheatsheets to go along

## Prerequisites - need to install manually  

* git
* fzf
  * `brew install fzf`
  * `$(brew --prefix)/opt/fzf/install`
* fd
* Command line tools
  * `xcode-select --install`
* Nerd Fonts
* diff-so-fancy

## Usage

You will need `git` to run these scripts.  
If you're on mac, then just install the command line developer tools for that, by running:
```bash
xcode-select --install
```

**Running from online**

```bash
curl -L https://github.com/gillyb/dotfiles/raw/master/online-install.sh | bash
```

**Running locally**

```
./install.sh
```


## To complete   

* Install neovim
* Install libraries required for neovim (run `:checkhealth` in neovim to see)
* fd & ripgrep
* Nerd Fonts (https://www.nerdfonts.com/font-downloads)
* diff-so-fancy
