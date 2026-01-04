# @nix-config-modules
{ inputs, ... }:
let
  inherit (inputs) niri;
in
{
  nix-config = {
    apps.niri = {
      home = {
        programs.niri.settings = { };
      };

      nixos =
        { pkgs, ... }:
        {
          programs.niri = {
            enable = true;
            package = pkgs.niri;
          };

          environment.systemPackages = with pkgs; [
            fuzzel
          ];
        };

      nixpkgs = {
        params.overlays = [
          niri.overlays.niri
        ];
      };
    };

    modules = {
      nixos = [
        #* niri modules add also home-manager module to all users
        niri.nixosModules.niri
      ];
    };
  };

}
