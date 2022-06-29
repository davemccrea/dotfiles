source ~/.asdf/asdf.fish

if status is-interactive
    # Commands to run in interactive sessions can go here
    theme_gruvbox dark hard

    if ! set -q TMUX
	    exec tmux
	  end

    set -gx EDITOR lvim
end

