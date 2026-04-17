#!/usr/bin/env bash

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES=$(cd -- "$SCRIPT_DIR/.." && pwd)

sudo rsync -av "$DOTFILES/install/services/" /etc/systemd/system/
sudo systemctl daemon-reload
