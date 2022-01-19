# dotfiles
A repo for all my settings (dot) files, and some cheatsheets to go along


## Things to add

* Check if there's a way to install the java runtime
* Create install file for tmux
* Fix installation for zsh
* Check all brew packages before reinstalling
* When an installation fails, print the command it tried to run, so it's easy to copy/paste
* After installing fzf, the user needs to run `$(brew --prefix)/opt/fzf/install` for it to create shortcuts in the terminal
* Fix installation for nvim - so it will install the plugins automatically (and I need to disable the color scheme until the plugins are installed i think)

* Make sure initial installations works (brew and node)

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

