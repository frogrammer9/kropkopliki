#!/bin/bash

DOTFILES="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

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

chsh -s $(whereis fish | awk '{print $2}')

read -p "Do you want to back up your existing config [Y/n]: " ans
case "$ans" in 
	[nN]|[nN][oO]) ;;
	*)
		[ -d "$HOME/.config" ] && mv "$HOME/.config" "$HOME/.config.backup.$(date +%s)"
	;;
esac

rm -rf "$HOME/.config"

mkdir -p "$HOME/.local/state"
mkdir -p "$HOME/.local/share"
mkdir -p "$HOME/.local/logs"

rm ~/.bash*

ln -sf "$DOTFILES/config" "$HOME/.config"
ln -sf "$DOTFILES/profile" "$HOME/.profile"

systemctl --user daemon-reload
systemctl --user enable --now ssh-agent

"$DOTFILES/install/grub.sh"
"$DOTFILES/install/plymouth.sh"
"$DOTFILES/install/ly.sh"
"$DOTFILES/install/browser.sh"
"$DOTFILES/install/git.sh"

rm -rf "$DOTFILES/install"

read -p "Dotfiles need system restart to fully configure. Do you want to reboot now [Y/n]: " ans
case "$ans" in 
	[nN]|[nN][oO]) ;;
	*) reboot;;
esac
