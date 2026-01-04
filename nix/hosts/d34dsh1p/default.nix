# @nix-config-modules
{ inputs, lib, ... }:
{
  nix-config.hosts.d34dsh1p = rec {
    kind = "nixos";
    system = "x86_64-linux";

    username = "nixos";
    homeDirectory = "/home/${username}";

    tags = {
      # ==> apps for "dev"
      "dev" = true;
      containers = true;

      # ==> policies
      passwordless = true;

      # == ui, styles
      appearance = true;

      # ==> misc
      wsl = true;
    };

    nixos = import ./configuration.nix;
    home = import ./home.nix;
  };

  nix-config.modules.nixos = [ inputs.nixos-wsl.nixosModules.wsl ];
}
