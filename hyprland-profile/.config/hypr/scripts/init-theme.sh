#!/bin/bash

if ! pgrep -x "awww-daemon" > /dev/null; then
    awww-daemon &
    sleep 0.5
fi

HYPR_DIR="$HOME/.config/hypr"
ROFI_DIR="$HOME/.config/rofi"
MAKO_DIR="$HOME/.config/mako"
WAYBAR_DIR="$HOME/.config/waybar"

CURRENT_SCHEME=$(gsettings get org.gnome.desktop.interface color-scheme)

if [ "$CURRENT_SCHEME" = "'prefer-light'" ]; then
    awww clear F8F4E6
    ln -sfn "theme-light.conf" "$HYPR_DIR/theme.conf"
    ln -sfn "rofi-light.rasi" "$ROFI_DIR/current-theme.rasi"
    ln -sf "config-light" "$MAKO_DIR/config"
    ln -sf "style-light.css" "$WAYBAR_DIR/style.css"
else
    awww clear 1A1A1D
    ln -sfn "theme-dark.conf" "$HYPR_DIR/theme.conf"
    ln -sfn "rofi-dark.rasi" "$ROFI_DIR/current-theme.rasi"
    ln -sf "config-dark" "$MAKO_DIR/config"
    ln -sf "style-dark.css" "$WAYBAR_DIR/style.css"
fi

hyprctl reload

makoctl reload

if pgrep -x waybar > /dev/null; then
    pkill -SIGUSR2 waybar
fi
