{ den, ... }:
{
  den.aspects.z4c1sz3.provides.declnix = {
    nixos =
      { pkgs, ... }:
      {
        security.pam.services.swaylock = { };
        environment.systemPackages = [ pkgs.swaylock-effects ];
      };

    hjem =
      { pkgs, ... }:
      {
        packages = [ pkgs.swaylock-effects ];
        files.".config/swaylock/config".text = ''
          color=000000
          show-failed-attempts
          clock
          indicator-idle-visible
          font=JetBrainsMono Nerd Font
          text-color=cdd6f4
          text-ver-color=cdd6f4
          text-wrong-color=f38ba8
          ring-color=585b70
          ring-ver-color=89b4fa
          ring-wrong-color=f38ba8
          key-hl-color=cdd6f4
        '';
        rum.desktops.niri = {
          spawn-at-startup = [
            [
              "swayidle"
              "-w"
              "timeout"
              "300"
              "swaylock -f"
              "timeout"
              "600"
              "niri msg action power-off-monitors"
              "resume"
              "niri msg action power-on-monitors"
            ]
          ];
          binds."Super+Alt+L" = {
            spawn = [ "swaylock" ];
            parameters.hotkey-overlay-title = "Lock the Screen: swaylock";
          };
        };
      };
  };
}
