# App shortcuts #
alias vim="nvim"
alias v="nvim"
#alias cat='bat'
alias du='ncdu --color dark -rr -x'
alias help='tldr'
alias chrome='/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome'
alias diff-so-fancy="~/.dotfiles/diff-so-fancy"

# Editing configuration files #
alias edit_profile="nvim ~/.config/fish/config.fish"
alias vimrc="nvim ~/.config/nvim/init.vim"
alias gitconfig="nvim ~/.gitconfig"

# Terminal shortcuts #
alias la="ll -a"
alias lla="ll -a"
alias ...="cd ../../"
alias ....="cd ../../../"



# use 'fd' output for 'fzf' command (fd: https://github.com/sharkdp/fd  fzf: https://github.com/junegunn/fzf)
set -g --export FZF_DEFAULT_COMMAND 'fd --type f'

# Default options for 'fzf' command: show 20% of height, show border, show below cursor
set -g --export FZF_DEFAULT_OPTS '--height 20 --border --color dark,hl:33,hl+:37,fg+:235,bg+:136,fg+:254 --color info:254,prompt:37,spinner:108,pointer:235,marker:235'


# Configure terminal prompt line #
function fish_prompt
  set_color green
  echo 
  echo (pwd)(set_color blue)'> ' (set_color normal)
end


alias nr="node /usr/local/lib/node_modules/@gillyb/nrun/index.js"
