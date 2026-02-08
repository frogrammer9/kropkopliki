#!/usr/bin/env bash
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
. "$SCRIPT_DIR/../.meta/include"

if (( BASH_VERSINFO[0] < 4 )); then
	echo "These dotfiles require Bash 4 or newer"
	return 1 2>/dev/null || exit 1
fi

ans=$(prompt_yn "Do you want dotfiles to manage ly config?")
set_var "V_MANAGE_LY" "$ans"

