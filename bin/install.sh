#!/bin/bash

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES=$(cd -- "$SCRIPT_DIR/.." && pwd)

if ! [ -d "$DOTFILES/install" ]; then
	echo "Kropkopliki have already been installed"
	exit 127
fi

if ! sudo -v; then
	echo "This installation script requires sudo to be installed and avaliable!"
	exit 128
fi

# install packages
sudo pacman -Syu --needed $(< "$DOTFILES/install/pkglist.txt")

read -p "Do you want to back up your existing config [Y/n]: " ans
case "$ans" in 
	[nN]|[nN][oO]) ;;
	*)
		[ -d "$HOME/.config" ] && mv "$HOME/.config" "$HOME/.config.backup.$(date +%s)"
		[ -d "$HOME/.local" ] && mv "$HOME/.local" "$HOME/.local.backup.$(date +%s)"
esac

rm -rf "$HOME/.config"

mkdir -p "$HOME/.local/state"
mkdir -p "$HOME/.local/share"
mkdir -p "$HOME/.local/logs"

ln -sf "$DOTFILES/config" "$HOME/.config"
ln -sf "$DOTFILES/profile" "$HOME/.profile"

"$DOTFILES/install/services.sh"
"$DOTFILES/install/sudo.sh"
"$DOTFILES/install/plymouth.sh"
"$DOTFILES/install/ly.sh"
"$DOTFILES/install/browser.sh"
"$DOTFILES/install/ssh.sh"
"$DOTFILES/install/git.sh"

rm -rf "$DOTFILES/install"

read -p "Dotfiles need system restart to fully configure. Do you want to reboot now [Y/n]: " ans
case "$ans" in 
	[nN]|[nN][oO]) ;;
	*) reboot;;
esac
