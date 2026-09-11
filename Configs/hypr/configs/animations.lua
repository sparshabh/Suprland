-- Animations Config
hl.config({
  animations = {
    enabled = true,
  },
})

-- Curves
hl.curve("easeOutQuint", { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } })
hl.curve("myBezier",     { type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1.05 } } })
hl.curve("specialWorkSwitch", { type = "bezier", points = { { 0.05, 0.7 }, { 0.1, 1 } } })
hl.curve("emphasizedAccel", { type = "bezier", points = { { 0.3, 0 }, { 0.8, 0.15 } } })
hl.curve("emphasizedDecel", { type = "bezier", points = { { 0.05, 0.7 }, { 0.1, 1 } } })
hl.curve("standard", { type = "bezier", points = { { 0.2, 0 }, { 0, 1 } } })

-- Anims
hl.animation({ leaf = "global",      enabled = true, speed = 3,    bezier = "default" })
hl.animation({ leaf = "windows",     enabled = true, speed = 4.79, bezier = "myBezier", style = "slide" })
hl.animation({ leaf = "windowsIn",   enabled = true, speed = 3,    bezier = "myBezier", style = "slide" })
hl.animation({ leaf = "windowsOut",  enabled = true, speed = 3,    bezier = "myBezier", style = "slide" })
hl.animation({ leaf = "border",      enabled = true, speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "borderangle", enabled = true, speed = 3,    bezier = "default" })
hl.animation({ leaf = "fade",        enabled = true, speed = 7,    bezier = "default" })

-- Caelestia-Shell Anims
hl.animation({ leaf = "workspaces", enabled = true, speed = 4, bezier = "standard" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 4, bezier = "emphasizedDecel", style = "slide" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 4, bezier = "emphasizedAccel", style = "slide" })
hl.animation({ leaf = "fadeLayers", enabled = true, speed = 4, bezier = "standard" })

