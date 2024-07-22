set -g fish_greeting
#set -x ASDF_DATA_DIR ~/.asdf
set -x EDITOR nvim
set -x PLUG_EDITOR "vscode://file/__FILE__:__LINE__"
set -x _ZO_DATA_DIR /var/home/david/.local/share

alias vi="nvim"
alias lg="lazygit"
alias ls="eza"
alias tm="tmux new-session -A -s main"
alias cdd="cd /var/home/david"
alias code="code --enable-features=UseOzonePlatform --ozone-platform=wayland"

theme_gruvbox dark hard
#fish_config theme choose "Rosé Pine Moon"
fish_add_path ~/.composer/vendor/bin
fish_add_path ~/.local/bin
fish_add_path ~/.local/bin/elixir-ls
fish_add_path ~/go/bin
fish_add_path /usr/local/go/bin
fish_add_path ~/.cargo/bin
fish_add_path ~/.cache/rebar3/bin

source ~/.asdf/asdf.fish
source ~/.cargo/env.fish

if status is-interactive
	zoxide init fish | source
	atuin init fish --disable-up-arrow | source
end


