{ den, ... }:
{
  den.aspects.declnix = {
    hjem =
      { pkgs, ... }:
      {
        packages = with pkgs; [
          codex
          wget
          curl
          firefox
        ];
      };

    includes = [
      den._.primary-user
      (den._.user-shell "zsh")
    ]
    ++ (with den.aspects; [
      dev-tools
      dev-ai
    ]);

    provides.z4c1sz3.nixos = {
      users.users.declnix.initialPassword = "test";
    };
  };

  den.hosts.x86_64-linux.z4c1sz3.users.declnix = { };

  den.aspects.z4c1sz3.provides.declnix = {
    hjem =
      { pkgs, ... }:
      {
        packages = with pkgs; [
          swaylock
          swayidle
        ];
        files.".config/swaylock/config".text = ''
          color=000000
          show-failed-attempts
        '';
        rum.programs.alacritty = {
          enable = true;
          settings.window.decorations = "None";
        };
        rum.programs.fuzzel.enable = true;
      };
  };
}
