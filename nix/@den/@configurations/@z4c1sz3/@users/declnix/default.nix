{ den, ... }:
{
  den.aspects.declnix.provides.z4c1sz3 =
    { pkgs, ... }:
    {
      nixos = {
        users.users.declnix.initialPassword = "test";
      };

      hjem = { pkgs, ... }: {
        packages = with pkgs; [
          codex
          wget
          curl
          firefox
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

      includes = [
        den._.primary-user
        (den._.user-shell "zsh")
      ]
      ++ (with den.aspects; [
        dev-tools
        dev-ai
      ]);
    };

  den.hosts.x86_64-linux.z4c1sz3.users.declnix = { };
}
