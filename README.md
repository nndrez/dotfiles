# dotfiles

Setup Hyprland su Arch Linux. Config versionate in Git, deployate con [GNU Stow](https://www.gnu.org/software/stow/).

## Panoramica

```
dotfiles/
├── base/              → fish, ghostty, mpv
└── hyprland-profile/  → hypr (Lua), waybar, rofi, mako, systemd services, …
```

Stow crea symlink `~/.config/<app>` → repo. Le app leggono da lì; le modifiche vivono nel repo.

```bash
cd ~/dotfiles && stow base hyprland-profile   # installa
stow -R hyprland-profile                    # riapplica dopo cambiamenti
stow -D base                               # rimuove symlink (non i file)
```

Dipendenze: `hyprland waybar rofi mako awww ghostty hyprlock hyprsunset grim slurp swappy wl-clipboard cliphist brightnessctl playerctl`.

---

## Stow

| Azione | Comando |
|--------|---------|
| Installare | `stow base hyprland-profile` |
| Riapplicare | `stow -R <pacchetto>` |
| Rimuovere symlink | `stow -D <pacchetto>` |
| Verificare | `ls -la ~/.config/hypr` → punta a `dotfiles/…` |

**Regola:** modifica sempre nel repo (o in `~/.config/` via symlink), mai copie duplicate.

**Nuova app:** crea `pacchetto/.config/foo/`, poi `stow <pacchetto>`.

**Varianti light/dark:** file `*-light` / `*-dark` + symlink in `init-theme.sh` (vedi Temi). I symlink runtime e lo stato locale sono esclusi tramite `.gitignore`.

---

## Architettura

```
                    gsettings color-scheme
                            │
                     Super+T (toggle)
                            │
                     init-theme.sh ──┬── symlink tema (waybar, rofi, mako, bordi)
                            │        ├── hyprctl reload
                            │        ├── wallpaper.sh
                            │        └── reload waybar / mako
                            │
              ┌─────────────┴─────────────┐
              ▼                           ▼
         Washi (light)               Sumi (dark)
```

All'avvio Hyprland (`autostart.lua`), parte `hyprland-session.target` che supervisiona via systemd:
- `waybar.service`
- `mako.service`
- `kanshi.service`
- `awww.service`
- `hyprsunset.service`

E viene eseguito `init-theme.sh`.

---

## Componenti

### Hyprland (`hypr/`)

Config nativa modulare in Lua (Hyprland >= 0.55 / 0.56): `hyprland.lua` include `monitors`, `env`, `autostart`, `input`, `animations`, `windowrules`, `keybindings`, `theme`.

Dopo modifiche: `hyprctl reload`.

### Temi — Washi / Sumi

| | Light (Washi) | Dark (Sumi) |
|-|---------------|-------------|
| UI | toni caldi chiari | toni scuri |
| Toggle | Super+T | |
| Fonte | `gsettings color-scheme` | |

`init-theme.sh` aggiorna symlink runtime:

| Componente | File |
|------------|------|
| Bordi | `theme.lua` → `theme-{light,dark}.lua` |
| Waybar | `style.css` → `style-{light,dark}.css` |
| Rofi | `current-theme.rasi` → `rofi-{light,dark}.rasi` |
| Mako | `config` → `config-{light,dark}` |
| Ghostty | automatico via `gsettings` (`theme = light:washi-light,dark:sumi-dark`) |
| Wallpaper | cartella `light/` o `dark/` |

### Wallpaper (`scripts/wallpaper.sh`)

- Cartelle: `~/Immagini/wallpapers/light/` e `dark/`
- Formati: jpg, png, webp
- Cambio tema o avvio → ultima immagine salvata, altrimenti random
- Cartella vuota → colore pieno di fallback
- Transizione: fade 0.4s
- Stato: `~/.local/state/wallpaper-{light,dark}`

### hyprsunset (`hyprsunset.conf`)

Filtro luce blu gestito via IPC nativo (`hyprctl hyprsunset`). Indipendente dal tema UI.

| Orario | Profilo |
|--------|---------|
| 07:00 | 5500K |
| 20:00 | 4300K, gamma 0.9 |

Script: `hypr/scripts/hyprsunset.sh` — Super+Shift+N disattiva filtro (identity), Super+Ctrl+N ripristina profilo (reset).

### hyprlock (`hypr/hyprlock.conf`)

Lock screen con blur e supporto PAM. Super+L.

### Monitor

- **kanshi** — profili laptop (`eDP-1`, scale 1.25) e dock (laptop spento, Eizo 1920x1200). Servizio user `kanshi.service`
- **monitors.lua** — fallback Hyprland (`preferred,auto`); non sostituisce kanshi

---

## Keybind

| Scorciatoia | Azione |
|-------------|--------|
| `Super+Q` | Terminale (Ghostty) |
| `Super+R` | Launcher (Rofi drun) |
| `Super+T` | Toggle tema light/dark |
| `Super+L` | Blocco schermo (Hyprlock) |
| `Super+C` | Chiudi finestra attiva |
| `Super+F` | Toggle finestra floating |
| `Super+P` | Toggle pseudotile |
| `Super+J` | Toggle split layout |
| `Super+Shift+W` | Wallpaper successivo |
| `Super+Shift+N` | Disattiva filtro notturno |
| `Super+Ctrl+N` | Ripristina filtro notturno |
| `Super+Shift+S` | Screenshot area (Grim + Slurp + Swappy) |
| `Super+Shift+Print` | Screenshot schermo intero |
| `Super+V` | Cronologia appunti (Cliphist + Rofi) |
| `Super+Shift+V` | Cancella cronologia appunti |
| `Super+1–0` | Vai al workspace 1–10 |
| `Super+Shift+1–0` | Sposta finestra al workspace 1–10 |
| `XF86Audio*` | Volume su/giù (ripetizione continua) e Mute |
| `XF86MonBrightness*` | Luminosità su/giù (ripetizione continua) |

---

## Workflow

1. Modifica config nel repo
2. Applica: `hyprctl reload`, `pkill -SIGUSR2 waybar`, riavvio servizio, ecc.
3. `git commit` quando stabile

Nuova macchina: `git clone` → `stow base hyprland-profile` → installa dipendenze → `systemctl --user enable kanshi waybar mako awww hyprsunset` → login.
