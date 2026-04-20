#!/usr/bin/env bash

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES=$(cd -- "$SCRIPT_DIR/.." && pwd)

echo "Setting up ly..."

sudo install -m 600 "$DOTFILES/install/ly/config.ini" /etc/ly/config.ini

sudo systemctl enable ly@tty1.service
sudo systemctl disable getty@tty1.service
