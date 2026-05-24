#!/bin/bash

# ===== Ensure sudo is avaliable =====
DOTFILES="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

if ! sudo -v; then
	echo "This installation script requires sudo to be installed and avaliable!"
	exit 128
fi

# ===== Install packages =====
sudo pacman -Syu --needed $(< "$DOTFILES/install/pkglist.txt")

# ===== User mod =====
sudo usermod -aG adm,uucp,optical,audio,video "$USER"
chsh -s $(whereis fish | awk '{print $2}')

read -p "Do you want to back up your existing config [Y/n]: " ans
case "$ans" in 
	[nN]|[nN][oO]) ;;
	*)
		[ -d "$HOME/.config" ] && mv "$HOME/.config" "$HOME/.config.backup.$(date +%s)"
	;;
esac

# ===== Copy config files =====
rm -rf "$HOME/.config"

mkdir -p "$HOME/.local/state"
mkdir -p "$HOME/.local/share"

rm ~/.bash*

cp -rf "$DOTFILES/config" "$HOME/.config"
cp -f "$DOTFILES/profile" "$HOME/.profile"

# ===== Systemd services =====
systemctl --user daemon-reload
systemctl --user enable --now ssh-agent
systemctl --user enable --now pipewire
systemctl --user enable --now wireplumber
systemctl --user enable --now pipewire-pulse

# ===== Secondary install scripts =====
"$DOTFILES/install/grub.sh"
"$DOTFILES/install/plymouth.sh"
"$DOTFILES/install/ly.sh"
"$DOTFILES/install/git.sh"

# ===== Reboot =====
read -p "Dotfiles need system restart to fully configure. Do you want to reboot now [Y/n]: " ans
case "$ans" in 
	[nN]|[nN][oO]) ;;
	*) reboot;;
esac
