# @nix-config-modules
{ lib, ... }:
{
  nix-config.apps.devbox = {
    home =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [ devbox ];
      };

    tags = [ "dev" ];
  };
}
