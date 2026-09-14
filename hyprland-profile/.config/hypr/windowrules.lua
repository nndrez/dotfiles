-- Window rules
-- Ref: https://wiki.hypr.land/Configuring/Basics/Window-Rules/

hl.window_rule({
    name = "suppress-maximize-events",
    match = { class = ".*" },
    suppress_event = "maximize",
})

hl.window_rule({
    name = "fix-xwayland-drags",
    match = {
        class = "^$",
        title = "^$",
        xwayland = true,
        float = true,
        fullscreen = false,
        pin = false,
    },
    no_focus = true,
})

hl.window_rule({
    name = "move-hyprland-run",
    match = { class = "hyprland-run" },
    move = { 20, "monitor_h-120" },
    float = true,
})

hl.window_rule({
    name = "swappy-editor",
    match = { class = "^swappy$" },
    float = true,
    center = true,
    size = { "80%", "80%" },
})
