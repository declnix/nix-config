# @nix-config-modules @proxy @impure
{ inputs, lib, ... }:
let
  inherit (builtins) getEnv;
in
{
  nix-config.hosts.l4p0stv01d = rec {
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

      # ==> ui, styles
      appearance = true;

      # ==> misc
      wsl = true;
      proxy = true;
    };

    nix-config.apps = {
      nvf.enable = false;
    };

    nixos = import ./configuration.nix;
    home = import ./home.nix;
  };

  nix-config.modules.nixos = [ inputs.nixos-wsl.nixosModules.wsl ];
}
