#!/usr/bin/env bash
fp=`ssh-keygen -lf ~/.ssh/id_rsa.pub | awk '{print $2}'`
keys=`ssh-add -l`
if [[ ! $keys == *"$fp"* ]]; then
    ssh-add
fi
git -C /home/trevor/env/ pull
git -C /home/trevor/emacs/ pull
git -C /home/trevor/org/ pull

