-----------------------
---- LOOK AND FEEL ----
-----------------------
local colors = require("colors")

hl.config({
    general = {
        gaps_in  = 7,
        gaps_out = 7,
        border_size = 1,
        col = {
            active_border   = colors.primary, 
            inactive_border = colors.shadow,
        },
        resize_on_border = true,
        allow_tearing = false,
        layout = "dwindle",
    },

    decoration = {
        rounding       = 10,
        rounding_power = 2,
        active_opacity   = 1.0,
        inactive_opacity = 1.0,
        shadow = {
            enabled      = true,
            range        = 4,
            render_power = 3,
            color        = 0xee1a1a1a,
        },
        blur = {
            enabled   = true,
            size      = 8,
            passes    = 2,
            vibrancy  = 0.1696,
            new_optimizations = true,
        },
    },
})
