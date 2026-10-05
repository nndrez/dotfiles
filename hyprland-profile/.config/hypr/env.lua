-- Environment variables
-- Ref: https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

-- Toolkit backends
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "wayland")
hl.env("GDK_BACKEND", "wayland,x11")

-- User defaults & services
hl.env("SSH_AUTH_SOCK", (os.getenv("HOME") or "") .. "/.bitwarden-ssh-agent.sock")
hl.env("BROWSER", "firefox")
