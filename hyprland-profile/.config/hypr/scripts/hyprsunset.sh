#!/bin/bash

ensure_running() {
    if ! pgrep -x hyprsunset >/dev/null 2>&1; then
        hyprsunset >/dev/null 2>&1 &
        sleep 0.2
    fi
}

case "$1" in
    identity)
        if pgrep -x hyprsunset >/dev/null 2>&1; then
            hyprctl hyprsunset identity >/dev/null 2>&1
            notify-send "Schermo" "Filtro notturno disattivato"
        fi
        ;;
    reset)
        ensure_running
        hyprctl hyprsunset reset >/dev/null 2>&1
        notify-send "Schermo" "Filtro notturno ripristinato"
        ;;
    *)
        echo "Usage: $0 {identity|reset}" >&2
        exit 1
        ;;
esac
