# Configurazione Hyprland (Lua)

Configurazione modulare attiva basata sull'interprete nativo Lua di Hyprland (>= 0.55 / 0.56).

I file legacy `*.conf` sono stati decommissionati.

## Ricarica della configurazione

Dopo modifiche ai moduli Lua o dopo `stow -R hyprland-profile`:

```bash
hyprctl reload
```

## Struttura Modulare

| Modulo Lua | Contenuto |
|---|---|
| `hyprland.lua` | Entry point, layout general e decoration |
| `monitors.lua` | Configurazione e profili dinamici monitor in Lua nativo |
| `env.lua` | Variabili d'ambiente e toolkit backend |
| `autostart.lua` | Avvio e shutdown sessione systemd, agenti e clipboard |
| `input.lua` | Layout tastiera, touchpad, gesture |
| `animations.lua` | Curve bezier e animazioni finestre/workspace |
| `windowrules.lua` | Regole finestre (XWayland, swappy, ecc.) |
| `keybindings.lua` | Scorciatoie da tastiera e controlli multimediali |
| `theme-{light,dark}.lua` | Palette colori bordi attivi/inattivi |
| `theme.lua` | Symlink runtime gestito da `init-theme.sh` |

## Display Management

I profili dinamici laptop/dock (`eDP-1` / Eizo esterno) sono gestiti nativamente in `~/.config/hypr/monitors.lua` tramite `hl.monitor()` e gli eventi `monitor.added` / `monitor.removed`.

## Note sui tool Hypr*

- `hyprlock.conf` e `hyprsunset.conf` utilizzano la sintassi Hyprlang propria dei rispettivi applicativi standalone.
- Il controllo di `hyprsunset` avviene via IPC nativo (`hyprctl hyprsunset identity|reset`).
