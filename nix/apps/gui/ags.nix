# @nix-config-modules
{ inputs, ... }:
let
  inherit (inputs) ags astal;
in
{
  nix-config = {
    apps.ags = {
      home =
        { pkgs, ... }:
        {
          programs.ags = {
            enable = true;
          };
        };
    };

    modules = {
      home-manager = [
        ags.homeManagerModules.default
      ];
    };
  };

}
