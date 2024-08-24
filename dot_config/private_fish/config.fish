if status is-interactive
	zoxide init fish | source
	# NOTE: disabled atuin because of weird performance issue
	# atuin init fish --disable-up-arrow | source
end

set -g fish_greeting
set -x EDITOR nvim
set -x _ZO_DATA_DIR /var/home/david/.local/share

alias vi="nvim"
alias lg="lazygit"
alias ls="eza"
alias cdd="cd /var/home/david"

#theme_gruvbox dark medium
#fish_config theme choose "Rosé Pine Moon"
fish_add_path ~/.composer/vendor/bin
fish_add_path ~/.local/bin
fish_add_path ~/go/bin
fish_add_path /usr/local/go/bin
fish_add_path ~/.cargo/bin
fish_add_path ~/.cache/rebar3/bin

source ~/.asdf/asdf.fish
source ~/.cargo/env.fish
