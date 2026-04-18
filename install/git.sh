#!/usr/bin/env bash

echo "Setting up git..."

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

read -rp "Git name: " name
read -rp "Git email: " email 

GIT_CFG_PATH="$SCRIPT_DIR/../config/git/config"

git config --file "$GIT_CFG_PATH" user.name "$name"
git config --file "$GIT_CFG_PATH" user.email "$email"
