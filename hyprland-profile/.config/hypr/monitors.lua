-- Monitor layout configuration (~/.config/hypr/monitors.lua)
-- Ref: https://wiki.hypr.land/Configuring/Basics/Monitors/
-- Gestione dinamica nativa in Hyprland Lua (senza kanshi)

local EIZO_DESC = "Eizo Nanao Corporation EV2430 80368064"

-- Fallback generale per altri monitor non mappati
hl.monitor({
    output = "",
    mode = "preferred",
    position = "auto",
    scale = 1,
})

-- Monitor esterno Eizo (profilo docked)
hl.monitor({
    output = "desc:" .. EIZO_DESC,
    mode = "1920x1200@59.95",
    position = "0x0",
    scale = 1,
})

local function has_external_monitor(excluded_name)
    for _, m in ipairs(hl.get_monitors() or {}) do
        if m.name ~= "eDP-1" and m.name ~= "FALLBACK" and m.name ~= excluded_name and not m.disabled then
            return true
        end
    end
    return false
end

local function sync_laptop_display(excluded_name)
    if has_external_monitor(excluded_name) then
        hl.monitor({
            output = "eDP-1",
            disabled = true,
        })
    else
        hl.monitor({
            output = "eDP-1",
            disabled = false,
            mode = "preferred",
            position = "auto",
            scale = 1,
        })
    end
end

sync_laptop_display(nil)

hl.on("monitor.added", function(m)
    if m and m.name ~= "eDP-1" and m.name ~= "FALLBACK" then
        hl.monitor({ output = "eDP-1", disabled = true })
    else
        sync_laptop_display(nil)
    end
end)

hl.on("monitor.removed", function(m)
    sync_laptop_display(m and m.name or nil)
end)
