#!/bin/bash

case "$1" in
    identity)
        pkill -x hyprsunset
        notify-send "Schermo" "Filtro disattivato"
        ;;
    reset)
        pkill -x hyprsunset
        sleep 0.1
        setsid hyprsunset >/dev/null 2>&1 &
        sleep 0.2
        temp=$(hyprctl hyprsunset temperature 2>/dev/null)
        notify-send "Schermo" "Profilo attivo · ${temp}K"
        ;;
    *)
        echo "Usage: $0 {identity|reset}" >&2
        exit 1
        ;;
esac
