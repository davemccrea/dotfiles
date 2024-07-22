function osversion
distrobox-host-exec grep OSTREE_VERSION /etc/os-release | awk -F= '{print $2}' | sed "s/'//g"
end
