set -g fish_greeting
set -x _ZO_DATA_DIR /var/home/david/.local/share
set -x ASDF_DATA_DIR /opt/asdf
set -x EDITOR nvim
set PATH ~/.local/bin $PATH

source /opt/asdf/asdf.fish
zoxide init fish --cmd cdd | source

alias vi="nvim"
alias vim="nvim"
alias cdd="z"
