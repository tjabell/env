#!/bin/bash
rm ~/.bashrc
ln -s ~/env/bashbootstrap ~/.bashrc
rm ~/.tmux.conf
ln -s ~/env/tmux.conf ~/.tmux.conf
rm ~/.gitconfig
ln -s ~/env/gitconfig ~/.gitconfig
git clone https://tjabell@github.com/tjabell/emacs.git ~/emacs


