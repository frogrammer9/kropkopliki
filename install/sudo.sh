#!/usr/bin/env bash

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES=$(cd -- "$SCRIPT_DIR/.." && pwd)

sed -i "s/user_name_phold/$USER/g" "$DOTFILES/install/kropkopliki_sudo"
sudo install -m 440 "$DOTFILES/install/kropkopliki_sudo" "/etc/sudoers.d/kropkopliki"
