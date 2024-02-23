set -g fish_greeting
#set -x ASDF_DATA_DIR ~/.asdf
set -x EDITOR nvim

fish_add_path ~/.composer/vendor/bin
fish_add_path ~/.local/bin
fish_add_path ~/.local/bin/elixir-ls
fish_add_path ~/go/bin

source ~/.asdf/asdf.fish

set -x _ZO_DATA_DIR /var/home/david/.local/share
zoxide init fish | source

alias vi="nvim"
alias vim="nvim"
alias cdd="cd /var/home/david"
