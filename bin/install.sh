#!/bin/bash
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

if ! sudo -v; then
	echo "This installation script requires sudo to be installed and avaliable!"
	exit 128
fi

DOTFILES=$(cd -- "$SCRIPT_DIR/.." && pwd)

# install packages (TODO)
sudo pacman -Syu #...

ans=$(prompt_yn "Do you want to back up your existing config" "y")
if [[ "$ans" == "yes" ]]; then
	mv "$HOME/.config" "$HOME/.config.backup"
	mv "$HOME/.local" "$HOME/.local.backup"
fi

rm -rf "$HOME/.config"
rm -rf "$HOME/.local/*"
mkdir -p "$HOME/.local/state"
mkdir -p "$HOME/.local/share"
mkdir -p "$HOME/.local/logs"

ln -sf "$DOTFILES/config" "$HOME/.config"
ln -sf "$DOTFILES/profile" "$HOME/.profile"

ans=$(prompt_yn "Dotfiles need system restart to fully configure. Do you want to reboot now?" "y")
if [[ "$ans" == "yes" ]]; then
	reboot
fi
