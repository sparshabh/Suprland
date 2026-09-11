--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

local suppressMaximizeRule = hl.window_rule({
    name  = "suppress-maximize-events",
    match = { class = ".*" },
    suppress_event = "maximize",
})

hl.window_rule({
    name  = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },
    no_focus = true,
})

hl.window_rule({
    name  = "move-hyprland-run",
    match = { class = "hyprland-run" },

    move  = "20 monitor_h-120",
    float = true,
})


-- Tearing

hl.window_rule({
    match = { class = "^(zen)$" },
    opacity = 0.99999
})


hl.window_rule({
    match = { class = "Timeshift-gtk" },
    tile = true,
})


-- Layerrules 
-- SwayNC Control Center Blur
hl.layer_rule({
    match = { namespace = "^swaync-control-center$" },
    blur = true,
    ignore_alpha = 0.2,
})

-- SwayNC Notification Popups Blur
hl.layer_rule({
    match = { namespace = "^swaync-notification-window$" },
    blur = true,
    ignore_alpha = 0.2,
})

-- Float TopLevel Terminal
hl.window_rule({ 
    match = { class = "toplevel_terminal" }, 
    float = true,
    workspace = "special:scratchpad" 
})
