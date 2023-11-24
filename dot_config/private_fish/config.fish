set -g fish_greeting

if status is-interactive 
and not set -q TMUX
    tmux attach -t base || tmux new -s base
end

source ~/.asdf/asdf.fish

set -gx EDITOR nvim

set PATH ~/.local/bin $PATH
