# dotfiles
A repo for all my settings (dot) files, and some cheatsheets to go along


## Things to add

* iterm2 (brew install --cask iterm2)
* install fd (brew install fd)
* neovim (brew install nvim)
  * sudo gem install neovim
  * brew install python
  * python3 -m pip install --user --upgrade pynvim
  * python2 -m pip install --user --upgrade pynvim
* tmux (brew install tmux)
* install sublimetext (brew install --cask sublime-text)
* install nerdfonts (brew tap homebrew/cask-fonts && brew install --cask font-hack-nerd-font)
* Make sure initial installations works (brew and node)
  * Make sure the beginning of the installation process works on the default mac terminal

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
