# Fedora set up

## Install dependencies

### fish

```
dnf install fish
```

### base16-shell

```
git clone https://github.com/chriskempson/base16-shell.git ~/.config/base16-shell
```

### asdf

```
# dependencies
dnf install curl git

# configure completions
mkdir -p ~/.config/fish/completions; and ln -s ~/.asdf/completions/asdf.fish ~/.config/fish/completions
```

Install the following using asdf:

* elixir + erlang
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
``
