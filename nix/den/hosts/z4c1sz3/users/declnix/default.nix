{ den, ... }:
{
  den.aspects.z4c1sz3.provides.declnix = {
    hjem =
      { pkgs, ... }:
      {
        enable = true;
        packages = with pkgs; [
          wget
          curl
          firefox
        ];
        rum.programs.alacritty = {
          enable = true;
          settings.window.decorations = "None";
        };
        rum.programs.fuzzel.enable = true;
      };

    nixos = {
      users.users.declnix.initialPassword = "test";
    };

    includes = [
      den.batteries.primary-user
      (den.batteries.user-shell "zsh")
    ]
    ++ (with den.aspects; [
      development
      assistant
    ]);
  };

  den.hosts.x86_64-linux.z4c1sz3.users.declnix = { };
}
