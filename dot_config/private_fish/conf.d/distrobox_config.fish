# https://github.com/89luca89/distrobox/issues/1671
if test -e /etc/fish/conf.d/distrobox_config.fish
	source /etc/fish/conf.d/distrobox_config.fish
	source $XDG_CONFIG_HOME/fish/functions/fish_prompt.fish
end
