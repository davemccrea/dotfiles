# Fedora set up

## Install dependencies

### fish

```
dnf install fish
```

### asdf

See asdf [Getting Started](https://asdf-vm.com/guide/getting-started.html#_3-install-asdf) guide.

```
# dependencies
dnf install curl git

# add the following to ~/.config/fish/config.fish
source ~/.asdf/asdf.fish

# configure completions
mkdir -p ~/.config/fish/completions; and ln -s ~/.asdf/completions/asdf.fish ~/.config/fish/completions
```

Install the following using asdf:

* elixir + erland
* neovim
* nodejs
* yarn

### yadm

#### install

```
git clone https://github.com/TheLocehiliosan/yadm.git ~/.yadm-project
ln -s ~/.yadm-project/yadm ~/bin/yadm
fish_add_path ~/bin
```

#### set up

```
yadm clone https://github.com/davemccrea/dotfiles.git
```
