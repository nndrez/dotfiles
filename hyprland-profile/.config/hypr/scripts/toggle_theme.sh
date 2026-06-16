#!/bin/bash

SCRIPT_DIR="$HOME/.config/hypr/scripts"
CURRENT_SCHEME=$(gsettings get org.gnome.desktop.interface color-scheme)

if [ "$CURRENT_SCHEME" = "'prefer-light'" ]; then
    gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
    MSG="Sumi (Dark)"
else
    gsettings set org.gnome.desktop.interface color-scheme 'prefer-light'
    MSG="Washi (Light)"
fi

"$SCRIPT_DIR/init-theme.sh"

notify-send "Sistema" "Modalità $MSG"
