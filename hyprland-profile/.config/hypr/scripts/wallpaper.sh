#!/bin/bash

WALLPAPER_BASE="$HOME/Immagini/wallpapers"
STATE_DIR="$HOME/.local/state"

AWWW_FADE_DURATION=0.4

mkdir -p "$WALLPAPER_BASE/light" "$WALLPAPER_BASE/dark" "$STATE_DIR"

theme_name() {
    if [ "$(gsettings get org.gnome.desktop.interface color-scheme)" = "'prefer-light'" ]; then
        echo light
    else
        echo dark
    fi
}

fallback_color() {
    if [ "$1" = light ]; then
        echo F8F4E6
    else
        echo 1A1A1D
    fi
}

find_wallpapers() {
    find "$WALLPAPER_BASE/$1" -maxdepth 1 -type f \
        \( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' -o -iname '*.webp' \) \
        2>/dev/null | sort
}

awww_set() {
    awww img "$1" \
        --transition-type fade \
        --transition-duration "$AWWW_FADE_DURATION" \
        --transition-fps 60 \
        --transition-bezier 0.25,0.1,0.25,1
}

apply() {
    local theme="${1:-$(theme_name)}"
    local state_file="$STATE_DIR/wallpaper-$theme"
    local wallpaper=""

    if [ -f "$state_file" ] && [ -f "$(cat "$state_file")" ]; then
        wallpaper=$(cat "$state_file")
    fi

    if [ -z "$wallpaper" ]; then
        wallpaper=$(find_wallpapers "$theme" | shuf -n 1)
    fi

    if [ -n "$wallpaper" ]; then
        awww_set "$wallpaper"
        echo "$wallpaper" > "$state_file"
    else
        awww clear "$(fallback_color "$theme")"
    fi
}

cycle() {
    local theme
    theme=$(theme_name)
    local state_file="$STATE_DIR/wallpaper-$theme"
    local current=""
    local next=""

    [ -f "$state_file" ] && current=$(cat "$state_file")

    while IFS= read -r file; do
        if [ -n "$next" ]; then
            next=$file
            break
        fi
        [ "$file" = "$current" ] && next="__advance__"
    done < <(find_wallpapers "$theme")

    if [ "$next" = "__advance__" ] || [ -z "$next" ]; then
        next=$(find_wallpapers "$theme" | head -1)
    fi

    if [ -n "$next" ]; then
        awww_set "$next"
        echo "$next" > "$state_file"
    else
        awww clear "$(fallback_color "$theme")"
    fi
}

case "$1" in
    apply) apply "$2" ;;
    cycle) cycle ;;
    *)
        echo "Usage: $0 {apply|cycle}" >&2
        exit 1
        ;;
esac
