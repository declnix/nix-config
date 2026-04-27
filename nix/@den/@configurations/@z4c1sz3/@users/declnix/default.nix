{ den, ... }:
{
  den.aspects.declnix.provides.z4c1sz3 = {
      hjem =
        { pkgs, ... }:
        {
          packages = with pkgs; [
            wget
            curl
            firefox
            gh
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
