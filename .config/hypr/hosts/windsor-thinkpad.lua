------------------
---- MONITORS ----
------------------
hl.monitor({
    output   = "eDP-1",
    mode     = "2880x1800@120",
    position = "auto",
    scale    = 2,
})

------------------
---- GESTURES ----
------------------
-- 3-finger swipe scrolls horizontally through workspaces/columns
hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })
