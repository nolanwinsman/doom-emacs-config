#!/usr/bin/env bash
# desc: Doom Emacs config
set -e

DOOM_CONFIG_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOOM_EMACS_DIR="$HOME/.config/emacs"
DOOM_LINK="$HOME/.config/doom"

echo "Installing Doom Emacs core..."
if [ ! -d "$DOOM_EMACS_DIR" ]; then
  git clone --depth 1 https://github.com/doomemacs/doomemacs "$DOOM_EMACS_DIR"
fi

echo "Running doom install (safe to re-run)..."
"$DOOM_EMACS_DIR/bin/doom" install

echo "Linking Doom config..."
if [ -e "$DOOM_LINK" ] && [ ! -L "$DOOM_LINK" ]; then
  echo "Error: $DOOM_LINK exists and is not a symlink. Back it up or remove it first."
  exit 1
fi
ln -sfn "$DOOM_CONFIG_DIR" "$DOOM_LINK"

echo "Syncing Doom..."
"$DOOM_EMACS_DIR/bin/doom" sync

echo "Doom Emacs setup complete."
