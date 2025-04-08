if status is-interactive
    {{- if eq .chezmoi.os "darwin" }}
    abbr -a cdd "cd /var/home/david"
    {{- end }}
end
