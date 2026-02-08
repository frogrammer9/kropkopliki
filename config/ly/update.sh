#!/usr/bin/env bash
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
. "$SCRIPT_DIR/../../.meta/include"

! "$SCRIPT_DIR/check_update.sh" && exit 0

if ! sudo -v; then
	echo "Ly config differs but sudo not avaliable!"
	exit 128
fi

sudo cp "$SCRIPT_DIR/config.ini" "$LYPATH/config.ini"
