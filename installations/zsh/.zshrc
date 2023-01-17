# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=/Users/gbarr/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to load
# Setting this variable when ZSH_THEME=random
# cause zsh load theme from this variable instead of
# looking in ~/.oh-my-zsh/themes/
# An empty array have no effect
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"
# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
)

source $ZSH/oh-my-zsh.sh


alias vim="nvim"
alias v="vim"

alias dotfiles="cd ~/dotfiles/"
alias dotsave="cd ~/dotfiles/ && git add . && git commit -m \"HYCYBH\" && cd -"
alias edit_profile="nvim ~/.zshrc"
alias reload_profile="source ~/.zshrc"
alias vimrc="nvim ~/.config/nvim/init.lua"
alias zshrc="nvim ~/.zshrc"
alias gitconfig="nvim ~/.gitconfig"

alias ll="ls -la"
alias la="ls -la"

alias du='ncdu --color dark -rr -x'
alias wtf='tldr'
alias diff-so-fancy="~/.dotfiles/diff-so-fancy"

alias tsnode='npx ts-node'
alias sb='switch_branch'
alias st='switch_tmux_env'

alias nr='npm_run'

alias chrome='/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome'

# eslint - fix staged git files
alias fix-staged='eslint $(git diff --name-only --cached) --fix'

# use 'fd' output for 'fzf' command (fd: https://github.com/sharkdp/fd  fzf: https://github.com/junegunn/fzf)
export FZF_DEFAULT_COMMAND='fd --type f'
# Default options for 'fzf' command: show 20% of height, show border, show below cursor
export FZF_DEFAULT_OPTS='--height 20 --reverse --border --color dark,hl:33,hl+:37,fg+:235,bg+:136,fg+:254 --color info:254,prompt:37,spinner:108,pointer:235,marker:235'


# utility functions
dev() {
  DIR=`fd . ~/dev -d 1 | fzf` && cd $DIR
}
switch_tmux_env() {
  SELECTED_ENV=`tmux ls | awk -F ":" '{print $1}' | fzf` && tmux a -t $SELECTED_ENV
}
switch_branch() {
  SELECTED_BRANCH=`git branch | fzf | xargs` && git checkout $SELECTED_BRANCH
}
npm_run() {
  CHOSEN_SCRIPT=`cat package.json | jq '.scripts | keys | .[]' | grep -v '\[' | grep -v '\]' | fzf`
  npm run ${CHOSEN_SCRIPT:1:-1}
}

install_language_servers() {
  sudo npm i -g typescript typescript-language-server
  sudo npm i -g bash-language-server
  sudo npm i -g @angular/language-server
  sudo npm i -g vscode-langservers-extracted
  sudo npm i -g pyright
  sudo npm i -g vim-language-server
  sudo npm i -g yaml-language-server
}
update_language_servers() {
  sudo npm update -g typescript typescript-language-server
  sudo npm update -g bash-language-server
  sudo npm update -g @angular/language-server
  sudo npm update -g vscode-langservers-extracted
  sudo npm update -g pyright
  sudo npm update -g vim-language-server
  sudo npm update -g yaml-language-server
}
alias ilangservers='install_language_servers'
alias ulangservers='update_language_servers'

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

#export NVM_DIR="$HOME/.nvm"
#[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
#[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Import local configurations if they exist (mostly for work-related stuff)
[ -f ~/.local.config.sh ] && source ~/.local.config.sh

export PATH=$PATH:/usr/local/bin/
# export PATH=$PATH:~/Library/Python/3.8/bin
# export PATH="/usr/local/opt/python@3.8/bin:$PATH"
export JAVA_HOME=$(/usr/libexec/java_home)

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/gbarr/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/gbarr/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/gbarr/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/gbarr/google-cloud-sdk/completion.zsh.inc'; fi


# Load Angular CLI autocompletion.
# source <(ng completion script)
