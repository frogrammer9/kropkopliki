#!/usr/bin/env bash
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
. "$SCRIPT_DIR/../.meta/include"

# in format supported by prompt()
SUPPORTED_LMS=("Ly:l:false")

ans=$(prompt "Choose a browser" "${SUPPORTED_LMS[@]}")

case "$ans" in
	"ly")
		#TODO: Get the directory that contains ly config
		set_var "V_LM" "ly"
		"$DOTFILES/config/ly/install.sh"
		;;
	*)
		echo "If you see this the code is wrong :)"
		exit 2
		;;
esac

