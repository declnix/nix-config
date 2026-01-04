# @nix-config-modules
{ lib, ... }:
{
  nix-config.hosts.bl1ndsp0t = rec {
    kind = "nixos";
    system = "x86_64-linux";

    username = "yehvaed";
    homeDirectory = "/home/${username}";

    tags = {
      # ==> apps for "dev"
      dev = true;
      containers = true;
      ai = true;

      # ==> policies
      passwordless = true;

      # == ui, styles
      appearance = true;
    };

    nix-config.apps = {
      # ==> desktop
      kde.enable = true;
      niri.enable = true;
      ags.enable = true;
      alacritty.enable = true;
    };

    nixos = import ./nixos/configuration.nix;
    home = import ./home.nix;
  };
}
