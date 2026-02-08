#!/usr/bin/env bash
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
. "$SCRIPT_DIR/../../.meta/include"

if [[ "$V_MANAGE_LY" == "yes" ]] && ! cmp -s "$LYPATH/config.ini" "$SCRIPT_DIR/config.ini"; then
	exit 0
else
	exit 1
fi
