set -g fish_greeting
set -x ASDF_DATA_DIR /opt/asdf
set -x EDITOR nvim

source /opt/asdf/asdf.fish

set -x _ZO_DATA_DIR /var/home/david/.local/share
zoxide init fish --cmd z | source

alias vi="nvim"
alias vim="nvim"
alias cdd="cd /var/home/david"
