#!/bin/bash
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
. "$SCRIPT_DIR/../.meta/include"
. "$SCRIPT_DIR/../.meta/packages"

if ! sudo -v; then
	echo "This installation script requires sudo to be installed and avaliable!"
	exit 128
fi

DOTFILES=$(cd -- "$SCRIPT_DIR/.." && pwd)
set_env "DOTFILES" "$DOTFILES"

# install packages
sudo pacman -Syu --needed "${PACKAGES[@]}"

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

# link config
ln -sf "$DOTFILES/config" "$HOME/.config"

# isntall opts
## install lm
"$SCRIPT_DIR/install_lm.sh"

## install shell
"$SCRIPT_DIR/install_shell.sh"

## install browser
"$SCRIPT_DIR/install_browser.sh"

# set .profile
echo "# This file is automaticly managed by the dotfiles. Do not edit it manually.
[ -f \"$ENVPATH\" ] && . \"$ENVPATH\"
" > "$HOME/.profile"

ans=$(prompt_yn "Dotfiles need system restart to fully configure. Do you want to reboot now?" "y")
if [[ "$ans" == "yes" ]]; then
	reboot
fi
