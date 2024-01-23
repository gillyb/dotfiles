# Uncomment this (and the line at the end of this file) to profile
# zmodload zsh/zprof


# Sets color variable such as $fg, $bg, $color and $reset_color
autoload colors; colors;

# Expand variables and commands in PROMPT variables
setopt prompt_subst
# Automatically push previous cd into the stack
setopt autopushd



#         #
# Aliases #
#         #

alias vim="nvim"
alias v="vim"

alias dotfiles="cd ~/dotfiles/"
alias dotsave="cd ~/dotfiles/ && git add . && git commit -m \"HYCYBH\" && git push && cd -"

alias edit_profile="nvim ~/.zshrc"
alias reload_profile="source ~/.zshrc"

alias vimrc="nvim ~/.config/nvim/init.lua"
alias zshrc="nvim ~/.zshrc"
alias gitconfig="nvim ~/.gitconfig"

alias ls="ls --color=always"
alias ll="ls -la --color=always"
alias la="ls -la --color=always"

alias du='ncdu --color dark -rr -x'
alias wtf='tldr'
alias diff-so-fancy="~/.dotfiles/diff-so-fancy"

alias sb='switch_branch'
alias st='switch_tmux_env'

alias nr='npm_run'

alias tsnode='npx ts-node'
alias chrome='/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome'

# jc = "just commit" - for super fast commits
alias jc='git c -am "HYCYBH"'

# eslint - fix staged git files
alias fix-staged='eslint $(git diff --name-only --cached) --fix'

# When i have no patience and I just want a super fast commit!
alias fp='git add . && git c -am "Fast commit baby" --no-verify && git push'


# FZF settings

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


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Import local configurations if they exist (mostly for work-related stuff)
[ -f ~/.local.config.sh ] && source ~/.local.config.sh

export PATH=$PATH:/usr/local/bin/:/Users/gbarr/dev/frontend/projects/proxy-tool/.bin/
# export PATH=$PATH:~/Library/Python/3.8/bin
# export PATH="/usr/local/opt/python@3.8/bin:$PATH"
export JAVA_HOME=$(/usr/libexec/java_home)

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/gbarr/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/gbarr/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
# if [ -f '/Users/gbarr/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/gbarr/google-cloud-sdk/completion.zsh.inc'; fi


# Load Angular CLI autocompletion.
# source <(ng completion script)

# pnpm
export PNPM_HOME="/Users/gbarr/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end


# Set prompt line format
PROMPT="%(?:%{$fg_bold[green]%}%1{➜%} :%{$fg_bold[red]%}%1{➜%} ) %{$fg[cyan]%}%c%{$reset_color%} "

# zprof
