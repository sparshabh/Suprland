-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

hl.env("XCURSOR_SIZE", "20")
hl.env("HYPRCURSOR_SIZE", "20")

hl.env("XCURSOR_THEME", "Bibata-Modern-Ice")
hl.env("HYPRCURSOR_THEME", "Bibata-Modern-Ice")

-- Hyprshot screenshot directory
hl.env("HYPRSHOT_DIR", "Pictures/Screenshots/")

-- Make Firefox faster
hl.env("MOZ_ENABLE_WAYLAND", "1")

-- Cursor settings
hl.config({
    cursor = {
        no_hardware_cursors = 1,
    }
})
