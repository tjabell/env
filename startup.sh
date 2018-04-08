#!/usr/bin/env bash
fp=`ssh-keygen -lf ~/.ssh/id_rsa.pub | awk '{print $2}'`
keys=`ssh-add -l`
if [[ ! $keys == *"$fp"* ]]; then
    ssh-add
fi
git -C /home/trevor/env/ pull --rebase &

if [[ -d /home/trevor/emacs/ ]]
then
git -C /home/trevor/emacs/ pull --rebase &    
fi

if [[ -d /home/trevor/org/ ]]
then
    git -C /home/trevor/org/ pull --rebase &
fi


wait
read -p "Start emacs client? " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
    systemctl --user start emacs
fi
