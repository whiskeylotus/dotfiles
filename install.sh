#!/bin/bash

ln -s ~/dotfiles/config_files/.vimrc ~/.vimrc
ln -s ~/dotfiles/config_files/.tmux.conf ~/.tmux.conf
ln -s ~/dotfiles/config_files/.gitconfig ~/.gitconfig
mkdir -p ~/.cache/vim

echo "source ~/dotfiles/scripts/aliases.zsh" >> ~/.zshrc
