#!/usr/bin/env bash
fp=`ssh-keygen -lf ~/.ssh/id_rsa.pub | awk '{print $2}'`
keys=`ssh-add -l`
if [[ ! $keys == *"$fp"* ]]; then
    ssh-add
fi
echo 'Updating Env'
git -C /home/trevor/env/ pull --rebase &

echo 'Updating Emacs'
if [[ -d /home/trevor/emacs/ ]]
then
git -C /home/trevor/emacs/ pull --rebase &    
fi

echo 'Updating Org'
if [[ -d /home/trevor/org/ ]]
then
    git -C /home/trevor/org/ pull --rebase &
fi


wait

echo '---- Env Status ----'
git -C /home/trevor/env/ status
echo '---- Emacs Status ----'
git -C /home/trevor/emacs/ status
echo '---- Org Status ----'
git -C /home/trevor/org/ status

read -p "Start emacs client? " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
    systemctl --user start emacs
fi
