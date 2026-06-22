# dotfiles

Setup Hyprland su Arch Linux. Config versionate in Git, deployate con [GNU Stow](https://www.gnu.org/software/stow/).

## Panoramica

```
dotfiles/
├── base/              → fish, ghostty, mpv
└── hyprland-profile/  → hypr, waybar, rofi, mako, kanshi, …
```

Stow crea symlink `~/.config/<app>` → repo. Le app leggono da lì; le modifiche vivono nel repo.

```bash
cd ~/dotfiles && stow base hyprland-profile   # installa
stow -R hyprland-profile                    # riapplica dopo cambiamenti
stow -D base                               # rimuove symlink (non i file)
```

Dipendenze: `hyprland waybar rofi mako awww ghostty kanshi hyprlock hyprsunset grim slurp swappy wl-clipboard cliphist brightnessctl playerctl`.

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

**Varianti light/dark:** file `*-light` / `*-dark` + symlink in `init-theme.sh` (vedi Temi).

Non committare symlink creati a runtime (`style.css`, `mako/config`, `theme.conf` quando punta al tema attivo).

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

All'avvio Hyprland (`autostart.conf`) partono i servizi e viene eseguito `init-theme.sh`.

---

## Componenti

### Hyprland (`hypr/`)

Config modulare: `hyprland.conf` include `monitors`, `env`, `autostart`, `input`, `animations`, `windowrules`, `keybindings`, `theme`, `hyprsunset`, `hyprlock`.

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
| Bordi | `theme.conf` → `theme-{light,dark}.conf` |
| Waybar | `style.css` → `style-{light,dark}.css` |
| Rofi | `current-theme.rasi` → `rofi-{light,dark}.rasi` |
| Mako | `config` → `config-{light,dark}` |
| Ghostty | automatico via `gsettings` |
| Wallpaper | cartella `light/` o `dark/` |

### Wallpaper (`scripts/wallpaper.sh`)

- Cartelle: `~/Immagini/wallpapers/light/` e `dark/`
- Formati: jpg, png, webp
- Cambio tema o avvio → ultima immagine salvata, altrimenti random
- Cartella vuota → colore pieno di fallback
- Transizione: fade 0.4s
- Stato: `~/.local/state/wallpaper-{light,dark}`

### hyprsunset (`hyprsunset.conf`)

Filtro luce blu per orario. Indipendente dal tema UI.

| Orario | Profilo |
|--------|---------|
| 07:00 | 5500K |
| 20:00 | 4300K, gamma 0.9 |

Script: `hypr/scripts/hyprsunset.sh` — Super+Shift+N spegne, Super+Ctrl+N riavvia.

### hyprlock (`hypr/hyprlock.conf`)

Lock screen. Sfondo screenshot + blur. Super+L.

### Monitor

- **kanshi** — profili laptop / dock
- **monitors.conf** — fallback generico

---

## Keybind

| Scorciatoia | Azione |
|-------------|--------|
| `Super+Q` | Terminale |
| `Super+R` | Launcher |
| `Super+T` | Tema light/dark |
| `Super+L` | Blocco schermo |
| `Super+Shift+W` | Wallpaper successivo |
| `Super+Shift+N` | Disattiva filtro notturno |
| `Super+Ctrl+N` | Ripristina filtro notturno |
| `Super+Shift+S` | Screenshot area |
| `Super+Shift+Print` | Screenshot schermo intero |
| `Super+V` | Appunti |
| `Super+C` | Chiudi finestra |
| `Super+F` | Float |
| `Super+1–0` | Workspace |
| `Super+Shift+1–0` | Sposta finestra |

---

## Workflow

1. Modifica config nel repo
2. Applica: `hyprctl reload`, `pkill -SIGUSR2 waybar`, riavvio servizio, ecc.
3. `git commit` quando stabile

Nuova macchina: `git clone` → `stow base hyprland-profile` → installa dipendenze → login.
