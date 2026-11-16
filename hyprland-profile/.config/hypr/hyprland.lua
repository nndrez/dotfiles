-- Hyprland Lua configuration (Hyprland >= 0.55)
-- Ref: https://wiki.hypr.land/Configuring/Start/

require("monitors")
require("env")
require("autostart")
require("input")
require("animations")
require("windowrules")
require("keybindings")

hl.config({
    general = {
        gaps_in = 6,
        gaps_out = 14,
        border_size = 1,
        resize_on_border = false,
        allow_tearing = false,
        layout = "dwindle",
    },

    decoration = {
        rounding = 6,
        rounding_power = 2,
        active_opacity = 1.0,
        inactive_opacity = 0.94,

        shadow = {
            enabled = true,
            range = 10,
            render_power = 4,
            color = "rgba(00000028)",
        },

        blur = {
            enabled = true,
            size = 3,
            passes = 2,
            new_optimizations = true,
            vibrancy = 0.0,
        },
    },

    dwindle = {
        preserve_split = true,
    },

    misc = {
        force_default_wallpaper = 0,
        disable_hyprland_logo = true,
    },
})

local ok = pcall(require, "theme")
if not ok then
    require("theme-dark")
end
