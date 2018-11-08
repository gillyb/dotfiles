# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=/Users/gillyb/.oh-my-zsh

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

# User configuration

# Shortcuts to local dev directories
alias ff="cd /workspace/"
alias ffb="cd /workspace/beyond-ui/"
source ~/.bash_aliases
alias reload_profile="source ~/.zshrc"
alias vimrc="nvim ~/.config/nvim/init.vim"
alias zshrc="nvim ~/.zshrc"
alias lla="ll -a"

alias cat='bat'
alias du='ncdu --color dark -rr -x'
alias help='tldr'
alias diff-so-fancy="~/.dotfiles/diff-so-fancy"

# use 'fd' output for 'fzf' command (fd: https://github.com/sharkdp/fd  fzf: https://github.com/junegunn/fzf)
export FZF_DEFAULT_COMMAND='fd --type f'

# utility functions
# TODO: add some helpers here...

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

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/gillyb/google-cloud-sdk/path.zsh.inc' ]; then source '/Users/gillyb/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/gillyb/google-cloud-sdk/completion.zsh.inc' ]; then source '/Users/gillyb/google-cloud-sdk/completion.zsh.inc'; fi
source ~/venv/bin/activate
export PATH=$PATH:~/venv/bin/
export PATH=$PATH:/usr/local/bin/
export PATH=$PATH:/workspace/

alias review="git push origin HEAD:refs/for/develop"

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8



### Google specific stuff
#
# This is so I can work on google3 code from my laptop

# Mounting filesystem
export DESKTOP_HOSTNAME=gillyb.tlv.corp.google.com

RO_MOUNTS=()

RW_MOUNTS=(
    /usr/local/google/home/$USER
    /google/src/cloud/$USER)

mountdd() {
  (
    for d in ${RO_MOUNTS[@]} ${RW_MOUNTS[@]}; do
      if [[ ! -e "$d" ]]; then
        echo "mountpoint $d does not yet exist; creating it" >&2
        sudo mkdir -p "$d"
      fi
      if [[ ! -w "$d" ]]; then
        echo "mountpoint $d does not have write permissions; adding them" >&2
        echo "for user: $USER"
        sudo chown $USER:eng "$d"
        chmod 0700 "$d"
      fi
    done

    set -x
    for m in ${RO_MOUNTS[@]}; do sshfs -o reconnect -o ro "$DESKTOP_HOSTNAME:$m" "$m"; done
    for m in ${RW_MOUNTS[@]}; do sshfs -o reconnect "$DESKTOP_HOSTNAME:$m" "$m"; done
  )
}

umountdd() {
  (
    set -x
    for m in ${RO_MOUNTS[@]} ${RW_MOUNTS[@]}; do
      if type fusermount; then
        fusermount -u $m
      else
        # no fusermount on Mac
        umount $m
      fi
    done
  )
}


# TODO: Modify configs for better caching and speed
alias mg="sshfs -o reconnect gillyb.tlv.corp.google.com:/google/src/cloud/gillyb/ ~/mount/"
