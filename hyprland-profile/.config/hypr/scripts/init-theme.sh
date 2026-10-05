#!/bin/bash

if ! pgrep -x "awww-daemon" > /dev/null 2>&1; then
    awww-daemon > /dev/null 2>&1 &
    sleep 0.3
fi

HYPR_DIR="$HOME/.config/hypr"
ROFI_DIR="$HOME/.config/rofi"
MAKO_DIR="$HOME/.config/mako"
WAYBAR_DIR="$HOME/.config/waybar"
SCRIPT_DIR="$HYPR_DIR/scripts"

CURRENT_SCHEME=$(gsettings get org.gnome.desktop.interface color-scheme)

if [ "$CURRENT_SCHEME" = "'prefer-light'" ]; then
    ln -sfn "theme-light.lua" "$HYPR_DIR/theme.lua"
    ln -sfn "rofi-light.rasi" "$ROFI_DIR/current-theme.rasi"
    ln -sfn "config-light" "$MAKO_DIR/config"
    ln -sfn "style-light.css" "$WAYBAR_DIR/style.css"
else
    ln -sfn "theme-dark.lua" "$HYPR_DIR/theme.lua"
    ln -sfn "rofi-dark.rasi" "$ROFI_DIR/current-theme.rasi"
    ln -sfn "config-dark" "$MAKO_DIR/config"
    ln -sfn "style-dark.css" "$WAYBAR_DIR/style.css"
fi

hyprctl reload > /dev/null 2>&1

"$SCRIPT_DIR/wallpaper.sh" apply

makoctl reload > /dev/null 2>&1

if pgrep -x waybar > /dev/null 2>&1; then
    pkill -SIGUSR2 waybar
fi
