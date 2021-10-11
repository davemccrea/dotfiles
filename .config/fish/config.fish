source ~/.asdf/asdf.fish

if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Base16 Shell
if status --is-interactive
    set BASE16_SHELL "$HOME/.config/base16-shell/"
    source "$BASE16_SHELL/profile_helper.fish"
end
