-- Animations
-- Ref: https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/

hl.config({
    animations = {
        enabled = true,
    },
})

hl.curve("sharpIn", { type = "bezier", points = { { 0.4, 0 }, { 0.2, 1 } } })
hl.curve("easeOutExpo", { type = "bezier", points = { { 0.16, 1 }, { 0.3, 1 } } })
hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })

hl.animation({ leaf = "windows", enabled = true, speed = 3, bezier = "easeOutExpo", style = "slide" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 3, bezier = "easeOutExpo", style = "slide" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 2, bezier = "sharpIn", style = "slide" })
hl.animation({ leaf = "border", enabled = true, speed = 1, bezier = "linear" })
hl.animation({ leaf = "fade", enabled = true, speed = 2, bezier = "easeOutExpo" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 4, bezier = "easeOutExpo", style = "slidefade 20%" })
