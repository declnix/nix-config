local mainMod = "SUPER"
local terminal = "alacritty"

hl.monitor({
  output = "",
  mode = "preferred",
  position = "auto",
  scale = 1,
})

hl.env("XDG_CURRENT_DESKTOP", "Hyprland", true)
hl.env("XDG_SESSION_DESKTOP", "Hyprland", true)
hl.env("XDG_SESSION_TYPE", "wayland", true)

hl.config({
  input = {
    kb_layout = "pl",
    touchpad = {
      natural_scroll = true,
      tap_to_click = true,
    },
  },
})

hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + M", hl.dsp.exit())
