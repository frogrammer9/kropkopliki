#!/usr/bin/env bash
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

git -C "$DOTFILES" fetch origin main &>/dev/null
LOCAL=$(git -C "$DOTFILES" rev-parse HEAD)
REMOTE=$(git -C "$DOTFILES" rev-parse origin/main)

[[ "$LOCAL" != "$REMOTE" ]] && git -C "$DOTFILES" reset --hard origin/main

exit 0
