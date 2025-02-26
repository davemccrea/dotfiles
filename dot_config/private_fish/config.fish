if status is-interactive
	# zoxide "z" is a smarter cd command
	zoxide init fish | source
	# atuin stores shell history in a sqlite database
	atuin init fish | source
	# starship is a prompt
	# starship init fish | source
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
fish_add_path ~/.local/bin
fish_add_path ~/go/bin
fish_add_path /usr/local/go/bin
fish_add_path ~/.cargo/bin
fish_add_path ~/.cache/rebar3/bin
fish_add_path /opt/nvim-linux64/bin
fish_add_path ~/bin
fish_add_path ~/.mix/escripts
fish_add_path ~/.local/bin/elixir-ls
