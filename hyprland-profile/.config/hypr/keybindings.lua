-- Keybindings
-- Ref: https://wiki.hypr.land/Configuring/Basics/Binds/

local terminal = "ghostty"
local menu = "rofi -show drun"
local mainMod = "SUPER"

hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + C", hl.dsp.window.kill())
hl.bind(mainMod .. " + F", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"))

hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "l" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "r" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "u" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "d" }))

for i = 1, 10 do
    local key = i % 10
    hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

local volume_notify = 'notify-send -e -h string:x-canonical-private-synchronous:volume -h int:value:"$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk \'{print $2*100}\')" "Volume"'

hl.bind(
    "XF86AudioRaiseVolume",
    hl.dsp.exec_cmd('wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+ && ' .. volume_notify),
    { release = true, locked = true }
)
hl.bind(
    "XF86AudioLowerVolume",
    hl.dsp.exec_cmd('wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%- && ' .. volume_notify),
    { release = true, locked = true }
)
hl.bind(
    "XF86AudioMute",
    hl.dsp.exec_cmd('wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle && notify-send -e -h string:x-canonical-private-synchronous:volume "Volume" "Mute toggled"'),
    { release = true, locked = true }
)

local brightness_notify = 'notify-send -e -h string:x-canonical-private-synchronous:brightness -h int:value:"$(brightnessctl i | grep -oP \'\\(\\K\\d+(?=%\\))\')" "Luminosità"'

hl.bind(
    "XF86MonBrightnessUp",
    hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+ && " .. brightness_notify),
    { release = true, locked = true }
)
hl.bind(
    "XF86MonBrightnessDown",
    hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%- && " .. brightness_notify),
    { release = true, locked = true }
)

hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

hl.bind(mainMod .. " + L", hl.dsp.exec_cmd("hyprlock -c ~/.config/hypr/hyprlock.conf"))
hl.bind(mainMod .. " + T", hl.dsp.exec_cmd("~/.config/hypr/scripts/toggle_theme.sh"))
hl.bind(mainMod .. " + SHIFT + W", hl.dsp.exec_cmd("~/.config/hypr/scripts/wallpaper.sh cycle"))
hl.bind(mainMod .. " + SHIFT + N", hl.dsp.exec_cmd("~/.config/hypr/scripts/hyprsunset.sh identity"))
hl.bind(mainMod .. " + CTRL + N", hl.dsp.exec_cmd("~/.config/hypr/scripts/hyprsunset.sh reset"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd('grim -g "$(slurp)" - | swappy -f -'))
hl.bind(mainMod .. " + SHIFT + Print", hl.dsp.exec_cmd("grim ~/Immagini/$(date +'%Y-%m-%d_%H-%M-%S').png"))
hl.bind(mainMod .. " + V", hl.dsp.exec_cmd('cliphist list | rofi -dmenu -p "Appunti" | cliphist decode | wl-copy'))
hl.bind(mainMod .. " + SHIFT + V", hl.dsp.exec_cmd('cliphist wipe && notify-send "Appunti" "Cronologia cancellata"'))
