#!/bin/bash

# crontab -e
# @daily cd ~/repos ; bash ~/homelab-devops/git-pull-all.sh

for dir in */; do
  [ -d "$dir/.git" ] && git -C "$dir" pull
done
