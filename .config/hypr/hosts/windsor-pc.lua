------------------
---- MONITORS ----
------------------
hl.monitor({
    output   = "HDMI-A-1",
    mode     = "7680x2160@120",
    position = "auto",
    scale    = 1.5,

    bitdepth      = 10,
    cm            = "hdr",
    sdrbrightness = 1.2,
    sdrsaturation = 0.9,
    vrr           = 2,
})

hl.monitor({
    output   = "HDMI-A-2",
    mode     = "2560x2880",
    position = "0x0",
    scale    = 1.5,
})

-- Ref https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/
-- Odyssey G9 (ultrawide) scrolls horizontally (the default); the DualUp is
-- portrait-ish, so its workspace scrolls vertically instead.
hl.workspace_rule({ workspace = "6", monitor = "HDMI-A-2", default = true, layout_opts = { direction = "down" } })
