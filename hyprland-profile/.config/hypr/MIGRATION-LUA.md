# Migrazione Hyprland → Lua

Config attiva: `hyprland.lua` + moduli `*.lua` (Hyprland >= 0.55).

I file `*.conf` originali restano nel repo per rollback rapido.

## Attivazione

Dopo `stow -R hyprland-profile`, riavvia Hyprland oppure:

```bash
hyprctl reload
```

Se esiste `hyprland.lua`, Hyprland **non** carica `hyprland.conf`.

## Rollback a hyprlang

```bash
mv ~/.config/hypr/hyprland.lua ~/.config/hypr/hyprland.lua.bak
hyprctl reload
```

Per tornare a Lua, ripristina il file e ricarica.

## Struttura

| Lua | Conf legacy | Contenuto |
|-----|-------------|-----------|
| `hyprland.lua` | `hyprland.conf` | Entry point + general/decoration |
| `monitors.lua` | `monitors.conf` | Fallback Hyprland (`monitor=,preferred,auto`); layout reale = kanshi |
| `env.lua` | `env.conf` | Variabili ambiente |
| `autostart.lua` | `autostart.conf` | Avvio servizi |
| `input.lua` | `input.conf` | Input, gesture, device |
| `animations.lua` | `animations.conf` | Curve e animazioni |
| `windowrules.lua` | `windowrules.conf` | Window rules |
| `keybindings.lua` | `keybindings.conf` | Keybind |
| `theme-{light,dark}.lua` | `theme-{light,dark}.conf` | Colori bordi |
| `theme.lua` | `theme.conf` | Symlink runtime (init-theme.sh) |

## Kanshi

I profili laptop/dock restano in `~/.config/kanshi/config`. `monitors.lua` è
solo il fallback Hyprland (`preferred` / `auto`) per output non coperti.

Il daemon è `kanshi.service` (`WantedBy=hyprland-session.target`), avviato da
`autostart.lua` via `systemctl --user start hyprland-session.target`.

Profili:

- **mobile** — `eDP-1` attivo, scale 1.25
- **docked** — `eDP-1` disabilitato, Eizo EV2430 1920x1200@59.95

## Note

- `hyprlock.conf` e `hyprsunset.conf` restano in hyprlang (tool Hypr* non migrati).
- `init-theme.sh` crea il symlink `theme.lua` → `theme-{light,dark}.lua`.
- Test consigliato: collegare/scollegare il dock e verificare il passaggio laptop ↔ esterno.
