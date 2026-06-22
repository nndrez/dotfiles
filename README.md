# dotfiles

Configurazione personale per Arch Linux + Hyprland. Gestita con [GNU Stow](https://www.gnu.org/software/stow/).

## Struttura

```
dotfiles/
├── base/                  # Config trasversali (shell, terminale, …)
│   └── .config/
│       ├── fish/
│       └── ghostty/
└── hyprland-profile/      # Desktop Hyprland
    └── .config/
        ├── hypr/          # Hyprland, hyprsunset, script temi
        ├── hyprlock/
        ├── kanshi/
        ├── mako/
        ├── rofi/
        ├── waybar/
        ├── xdg-desktop-portal/
        └── systemd/user/
```

Ogni cartella sotto `.config/` diventa un symlink in `~/.config/<nome>`.

## Installazione

```bash
cd ~/dotfiles
stow base hyprland-profile

# systemd (se non già linkato)
mkdir -p ~/.config/systemd/user
ln -sfn ../../dotfiles/hyprland-profile/.config/systemd/user/hyprland-session.target \
  ~/.config/systemd/user/hyprland-session.target
```

Verifica:

```bash
ls -la ~/.config/hypr   # → ../dotfiles/hyprland-profile/.config/hypr
```

### Pacchetti di sistema (non versionati)

```bash
sudo pacman -S hyprland waybar rofi mako awww ghostty kanshi hyprlock hyprsunset \
  grim slurp swappy wl-clipboard cliphist brightnessctl playerctl \
  polkit-gnome gnome-keyring gsettings-desktop-schemas
```

## Come funziona Hyprland

`hyprland.conf` è il punto d'ingresso e include i file modulari:

| File | Contenuto |
|------|-----------|
| `monitors.conf` | Monitor (fallback generico) |
| `env.conf` | Variabili d'ambiente Wayland |
| `autostart.conf` | Servizi all'avvio |
| `input.conf` | Tastiera, touchpad, mouse |
| `animations.conf` | Animazioni finestre |
| `windowrules.conf` | Regole finestre |
| `keybindings.conf` | Scorciatoie |
| `hyprsunset.conf` | Filtro luce blu (profili orari) |

Dopo modifiche a config Hyprland: `hyprctl reload` (o logout).

## Sistema a temi (Washi / Sumi)

**Fonte di verità:** `gsettings org.gnome.desktop.interface color-scheme`

| Componente | Meccanismo |
|------------|------------|
| Hyprland | `hyprctl` bordi finestra |
| Waybar | symlink `style.css` → `style-{light,dark}.css` |
| Rofi | symlink `current-theme.rasi` → `rofi-{light,dark}.rasi` |
| Mako | symlink `config` → `config-{light,dark}` |
| Ghostty | `theme = light:washi-light,dark:sumi-dark` |
| Wallpaper | `awww clear` (colore pieno) |

Script:

- `hypr/scripts/init-theme.sh` — applica il tema (autostart + dopo toggle)
- `hypr/scripts/toggle_theme.sh` — alterna light/dark (`Super+T`)

I symlink runtime (`style.css`, `mako/config`, `current-theme.rasi`) sono creati da `init-theme.sh` e **non** vanno committati.

## hyprsunset

Config: `hypr/hyprsunset.conf` (profili orari temperatura/gamma).

```bash
hyprctl hyprsunset temperature    # leggi stato
hyprctl hyprsunset temperature 5500
hyprctl hyprsunset identity        # disattiva filtro
pkill hyprsunset; hyprsunset &     # ripristina profilo schedulato
```

| Keybind | Azione |
|---------|--------|
| `Super+Shift+N` | Disattiva filtro |
| `Super+Ctrl+N` | Riavvia hyprsunset (profilo orario) |

> `hyprctl hyprsunset reset` e `profile` non funzionano in v0.3.3.

## Aggiungere una config

### Nuovo file in un pacchetto esistente

Esempio: nuovo modulo waybar.

```bash
# 1. Crea il file nel repo
vim hyprland-profile/.config/waybar/config.jsonc

# 2. Se stow è già attivo, il symlink si aggiorna da solo
# 3. Riavvia il servizio interessato
pkill -SIGUSR2 waybar
```

### Nuova app in `~/.config`

```bash
# 1. Aggiungi al pacchetto giusto
mkdir -p hyprland-profile/.config/nuova-app
vim hyprland-profile/.config/nuova-app/config

# 2. Applica stow (crea il symlink)
cd ~/dotfiles && stow hyprland-profile

# 3. Autostart (se daemon)
vim hyprland-profile/.config/hypr/autostart.conf
```

### Nuovo pacchetto stow

```bash
mkdir -p nuovo-pacchetto/.config/foo
# …aggiungi file…
cd ~/dotfiles && stow nuovo-pacchetto
```

### Config con varianti light/dark

Pattern usato da waybar, rofi, mako:

1. Crea `config-light` e `config-dark` nel repo
2. In `init-theme.sh`, aggiungi il symlink al tema corretto
3. Non committare il symlink runtime (`config`, `style.css`, …)

## Rimuovere una config

```bash
# 1. Rimuovi il symlink stow (non i file nel repo)
cd ~/dotfiles && stow -D hyprland-profile   # intero pacchetto
# oppure, per una sola app:
stow -D --no-folding hyprland-profile/.config/nuova-app  # non standard;
# meglio: stow -D hyprland-profile && rimuovi dal repo && stow hyprland-profile

# 2. Elimina dal repo
git rm -r hyprland-profile/.config/nuova-app

# 3. Rimuovi autostart/keybind se presenti
vim hyprland-profile/.config/hypr/autostart.conf
vim hyprland-profile/.config/hypr/keybindings.conf
```

Per togliere un singolo servizio senza stow -D completo:

```bash
# Rimuovi autostart + file dal repo + riapplica stow
cd ~/dotfiles && stow -R hyprland-profile
```

## Keybind principali

| Scorciatoia | Azione |
|-------------|--------|
| `Super+Q` | Terminale (ghostty) |
| `Super+R` | Launcher (rofi) |
| `Super+T` | Toggle tema light/dark |
| `Super+L` | Blocco schermo (hyprlock) |
| `Super+Shift+N` | Disattiva filtro hyprsunset |
| `Super+Ctrl+N` | Ripristina profilo hyprsunset |
| `Super+Shift+S` | Screenshot area (grim+slurp+swappy) |
| `Super+V` | Cronologia appunti (cliphist+rofi) |

## Note

- **Kanshi** gestisce profili monitor laptop/dock (`kanshi/config`); `monitors.conf` è il fallback.
- **Wallpaper:** attualmente colore pieno via `awww` in `init-theme.sh`. Immagini da cartella: da implementare.
- File generati a runtime (`waybar/style.css`, `mako/config`, `rofi/current-theme.rasi`) non vanno nel repo.
