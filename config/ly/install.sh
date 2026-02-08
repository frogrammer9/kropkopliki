#!/usr/bin/env bash
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
. "$SCRIPT_DIR/../../.meta/include"

if ! sudo -v; then
	echo "This installation script requires sudo to be installed and avaliable!"
	exit 128
fi

ans=$(prompt_yn "Do you want dotfiles to install ly login manager?" "y")
if [[ "$ans" == "yes" ]]; then
	sudo pacman -S --needed ly

	sudo systemctl enable ly@tty1
	
	ans=$(prompt_yn "Do you want to use dotfiles ly config?" "y")
	if [[ "$ans" == "yes" ]]; then

		ans=$(prompt_yn "Do you want to backup your old ly config?" "n")
		[[ "$ans" == "yes" ]] && sudo mv "$LYPATH/config.ini" "$LYPATH/config.ini.backup"

		sudo cp "$SCRIPT_DIR/config.ini" "$LYPATH/config.ini"

		ans=$(prompt_yn "Do you want to keep dotfiles ly config up to date?" "y")
		[[ "$ans" == "yes" ]] && set_var "V_MANAGE_LY" "yes"
	fi
fi
