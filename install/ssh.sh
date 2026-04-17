#!/usr/bin/env bash

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES=$(cd -- "$SCRIPT_DIR/.." && pwd)

sudo useradd -m -r -s /usr/sbin/nologin sshu
sudo passwd -l sshu

sudo groupadd sshusers
sudo usermod -aG sshusers "$USER"

sudo rsync -a --chown=sshu:sshu "$DOTFILES/sshu.home/" /home/sshu
sudo chmod -R 700 /home/sshu
sudo chgrp -R sshusers /home/sshu/bin
sudo chmod -R 750 /home/sshu/bin

sudo systemctl enable --now sshu-agent.service
