#!/bin/bash
set -e

# make symbolick link 
create_symlink() {
    src=$1
    dest=$2

    # make backup file
    if [ -e "$dest" ] || [ -L "$dest" ]; then
        mv "$dest" "$dest.bak"
    fi

    ln -sf "$src" "$dest"
}

# dotfiles path
DOTFILES_DIR="$HOME/dotfiles"

# tmux.conf
create_symlink "$DOTFILES_DIR/.tmux.conf" "$HOME/.tmux.conf"
# zshrc
create_symlink "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"
# gitconfig
create_symlink "$DOTFILES_DIR/git/.gitconfig" "$HOME/.gitconfig"
# Neovim
create_symlink "$DOTFILES_DIR/nvim" "$HOME/.config/nvim"


echo "Success"

