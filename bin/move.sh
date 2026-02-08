#!/bin/bash
set -e
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
. "$SCRIPT_DIR/../.meta/include"

if [[ -z "$1" ]]; then 
	echo "Usage $0 <new-dotfiles-path>"
	exit 3
fi

mkdir -p "$(dirname "$1")"
mv "$DOTFILES" "$1"
set_env "DOTFILES" "$1"
[[ -L "$HOME/.config" ]] && rm -f "$HOME/.config"
ln -sf "$DOTFILES" "$HOME/.config"
