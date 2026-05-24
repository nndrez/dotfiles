#!/bin/bash

if ! pgrep -x "awww-daemon" > /dev/null; then
    awww-daemon &
    sleep 0.5 
fi

ROFI_DIR="$HOME/.config/rofi"
MAKO_DIR="$HOME/.config/mako"

CURRENT_SCHEME=$(gsettings get org.gnome.desktop.interface color-scheme)

if [ "$CURRENT_SCHEME" = "'prefer-light'" ]; then
    hyprctl --batch "keyword general:col.active_border rgba(2C2826ee) ; keyword general:col.inactive_border rgba(E0DCD3aa)"
    awww clear F8F4E6
    ln -sfn "$ROFI_DIR/rofi-light.rasi" "$ROFI_DIR/current-theme.rasi"
    ln -sf "$MAKO_DIR/config-light" "$MAKO_DIR/config"
else
    hyprctl --batch "keyword general:col.active_border rgba(f0f0f0ee) ; keyword general:col.inactive_border rgba(2a2a2aaa)"
    awww clear 1A1A1D
    ln -sfn "$ROFI_DIR/rofi-dark.rasi" "$ROFI_DIR/current-theme.rasi"
    ln -sf "$MAKO_DIR/config-dark" "$MAKO_DIR/config"
fi

makoctl reload
