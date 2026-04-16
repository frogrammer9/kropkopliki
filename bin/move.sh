#!/bin/bash
set -e
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

if [[ -z "$1" ]]; then 
	echo "Usage $0 <new-dotfiles-path>"
	exit 3
fi

mkdir -p "$(dirname "$1")"
mv "$SCRIPT_DIR/../.." "$1"

[[ -L "$HOME/.config" ]] && rm -f "$HOME/.config"
ln -sf "$1/config" "$HOME/.config"

[[ -L "$HOME/.profile" ]] && rm -f "$HOME/.profile"
ln -sf "$1/profile" "$HOME/.profile"
