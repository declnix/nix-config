# @nix-config-modules
{ inputs, ... }:
{
  nix-config.apps.nix-index = {
    enable = true;

    nixos =
      { pkgs, ... }:
      {
        programs.nix-index-database.comma.enable = true;
      };
  };

  nix-config.modules.nixos = [
    inputs.nix-index-database.nixosModules.nix-index
  ];
}
