{ den, ... }:
{
  den.aspects.z4c1sz3.provides.declnix = {
    hjem =
      { ... }:
      {
        waybar.enable = true;
        waybar.extraConfig = builtins.toJSON {
          layer = "top";
          position = "top";
          height = 30;
          modules-left = [ ];
          modules-center = [ ];
          modules-right = [
            "network"
            "battery"
            "clock"
          ];
          clock = {
            format = "󰃰  {:%d %b %H:%M}";
            tooltip = false;
          };
          network = {
            format-wifi = "󰤨  {essid}";
            format-disconnected = "󰤭";
            tooltip = false;
          };
          battery = {
            format = "{icon}  {capacity}%";
            format-charging = "󰂄  {capacity}%";
            format-icons = [
              "󰁺"
              "󰁻"
              "󰁼"
              "󰁽"
              "󰁾"
              "󰁿"
              "󰂀"
              "󰂁"
              "󰂂"
              "󰁹"
            ];
            states = {
              warning = 30;
              critical = 15;
            };
            tooltip = false;
          };
        };
        waybar.extraStyle = ''
          * {
            all: unset;
            font-family: "JetBrainsMono Nerd Font";
            font-size: 13px;
          }
          window#waybar {
            background: #1a1a1a;
            color: #e0e0e0;
          }
          .modules-right {
            padding: 2px 8px;
          }
          #network,
          #battery,
          #clock {
            margin: 0 6px;
          }
          #network {
            color: #4a9eff;
          }
          #battery {
            color: #44cc44;
          }
          #battery.charging {
            color: #44cc44;
          }
          #battery.warning:not(.charging) {
            color: #ffaa00;
          }
          #battery.critical:not(.charging) {
            color: #ff4444;
          }
        '';
      };
  };
}
