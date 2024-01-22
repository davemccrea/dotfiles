source /opt/asdf/asdf.fish
zoxide init fish --cmd j | source

set -g fish_greeting
set -x ASDF_DATA_DIR /opt/asdf
set -x EDITOR nvim
set PATH ~/.local/bin $PATH

alias vi="nvim"
alias vim="nvim"
