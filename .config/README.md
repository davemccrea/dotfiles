# Fedora set up

## Install dependencies

### fish

```
dnf install fish
```

### asdf

See asdf [Getting Started](https://asdf-vm.com/guide/getting-started.html#_3-install-asdf) guide.

```
# add the following to ~/.config/fish/config.fish
source ~/.asdf/asdf.fish

# configure completions
mkdir -p ~/.config/fish/completions; and ln -s ~/.asdf/completions/asdf.fish ~/.config/fish/completions
```

Install the following using asdf:

* elixir + erlang
* neovim
* nodejs
* yarn

### vim-plug

```
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
```

### elixir-ls

```
cd bin
git clone https://github.com/elixir-lsp/elixir-ls.git
mix deps.get && mix compile
```

### treesitter for elixir

`tree-sitter-cli` is required to install elixir.

```
# install using npm
npm install -g tree-sitter-cli

# then open neovim and run:
:TSInstall elixir
```

### yadm

#### install

```
git clone https://github.com/TheLocehiliosan/yadm.git ~/.yadm-project
ln -s ~/.yadm-project/yadm ~/bin/yadm
fish_add_path ~/bin
```

#### load dotfiles on exiting system

```
yadm clone git@github.com:davemccrea/dotfiles.git
yadm status
```
