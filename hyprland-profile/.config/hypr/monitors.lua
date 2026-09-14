-- Monitor layout configuration (~/.config/hypr/monitors.lua)
-- Ref: https://wiki.hypr.land/Configuring/Basics/Monitors/
--
-- NOTA: La gestione dinamica dei profili (docking/undocking, risoluzioni, scala)
-- è interamente demandata a Kanshi (~/.config/kanshi/config).

-- Fallback generale per monitor non mappati esplicitamente da Kanshi
hl.monitor({
    output = "",
    mode = "preferred",
    position = "auto",
    scale = 1,
})
