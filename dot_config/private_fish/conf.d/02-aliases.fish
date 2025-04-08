if status is-interactive
    alias vi="nvim"
    alias lg="lazygit"
    {{- if eq .chezmoi.os "linux" }}
    alias ls="lsd"
    {{- end }}
end
