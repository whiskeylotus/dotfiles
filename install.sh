#!/bin/bash

ln -s ~/dotfiles/.vimrc ~/.vimrc
ln -s ~/dotfiles/.tmux.conf ~/.tmux.conf
ln -s ~/dotfiles/.gitconfig ~/.gitconfig
mkdir -p ~/.cache/vim

echo "source ~/dotfiles/aliases.zsh" >> ~/.zshrc
