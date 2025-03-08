if status is-interactive
    source "$HOME/.cargo/env.fish"
    source "$HOME/.atuin/bin/env.fish"
    zoxide init fish | source
    atuin init fish | source
end
