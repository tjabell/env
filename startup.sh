#!/usr/bin/env bash
git -C /home/trevor/env/ pull
git -C /home/trevor/emacs/ pull
git -C /home/trevor/org/ pull
systemctl --user restart emacs
