#!/bin/bash
rm ~/.bashrc
ln -s ~/env/bashbootstrap ~/.bashrc
rm ~/.tmux.conf
ln -s ~/env/tmux.conf ~/.tmux.conf
rm ~/.gitconfig
ln -s ~/env/gitconfig ~/.gitconfig
git clone https://tjabell@github.com/tjabell/emacs.git ~/emacs

# Enable user's emacs.service 
mkdir -p ~/.config/systemd/user
cp ~/emacs/emacs.service ~/.config/systemd/user/
systemctl --user daemon-reload
