#!/bin/bash

if ! pgrep -x "awww-daemon" > /dev/null; then
    awww-daemon &
    sleep 0.5 
fi

ROFI_DIR="$HOME/.config/rofi"
MAKO_DIR="$HOME/.config/mako"
WAYBAR_DIR="$HOME/.config/waybar"

CURRENT_SCHEME=$(gsettings get org.gnome.desktop.interface color-scheme)

if [ "$CURRENT_SCHEME" = "'prefer-light'" ]; then
    hyprctl --batch "keyword general:col.active_border rgba(2C2826ee) ; keyword general:col.inactive_border rgba(E0DCD3aa)"
    awww clear F8F4E6
    # LINK RELATIVI PER TEMA LIGHT
    ln -sfn "rofi-light.rasi" "$ROFI_DIR/current-theme.rasi"
    ln -sf "config-light" "$MAKO_DIR/config"
    ln -sf "style-light.css" "$WAYBAR_DIR/style.css"
else
    hyprctl --batch "keyword general:col.active_border rgba(f0f0f0ee) ; keyword general:col.inactive_border rgba(2a2a2aaa)"
    awww clear 1A1A1D
    # LINK RELATIVI PER TEMA DARK
    ln -sfn "rofi-dark.rasi" "$ROFI_DIR/current-theme.rasi"
    ln -sf "config-dark" "$MAKO_DIR/config"
    ln -sf "style-dark.css" "$WAYBAR_DIR/style.css"
fi

makoctl reload

if pgrep -x waybar > /dev/null; then
    pkill -SIGUSR2 waybar
fi
