source ~/.asdf/asdf.fish

if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -gx SUDO_EDITOR /home/david/.asdf/shims/nvim
set -gx VISUAL nvim /home/david/.asdf/shims/nvim
set -gx EDITOR nvim /home/david/.asdf/shims/nvim

