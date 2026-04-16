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
      niri
      alacritty
      fuzzel
      waybar
    ]);

    provides.bl1ndsp0t.nixos = {
      users.users.declnix.initialPassword = "test";
    };
  };

  den.hosts.x86_64-linux.bl1ndsp0t.users.declnix = { };
}
