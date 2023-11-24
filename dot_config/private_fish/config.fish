set -g fish_greeting

if status is-interactive
and not set -q TMUX
    if tmux has-session -t home
	exec tmux attach-session -t home
    else
        tmux new-session -s home
    end
end

source ~/.asdf/asdf.fish

set -gx EDITOR nvim

set PATH ~/.local/bin $PATH
