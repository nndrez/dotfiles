-- Animations (Sumi-e / Fude brush style)
-- Ref: https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/

hl.config({
    animations = {
        enabled = true,
    },
})

hl.curve("fude", { type = "bezier", points = { { 0.16, 1.0 }, { 0.3, 1.0 } } })
hl.curve("inkFade", { type = "bezier", points = { { 0.22, 1.0 }, { 0.36, 1.0 } } })
hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })

hl.animation({ leaf = "windows", enabled = true, speed = 4, bezier = "fude", style = "popin 93%" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 4, bezier = "fude", style = "popin 93%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 3, bezier = "inkFade", style = "popin 95%" })
hl.animation({ leaf = "border", enabled = true, speed = 2, bezier = "linear" })
hl.animation({ leaf = "fade", enabled = true, speed = 4, bezier = "inkFade" })
hl.animation({ leaf = "layers", enabled = true, speed = 3, bezier = "inkFade", style = "fade" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 4, bezier = "fude", style = "slidefade 12%" })
