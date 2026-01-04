# @nix-config-modules
{ lib, ... }:
{
  nix-config.apps.host = {
    enable = true;

    nixos =
      { host, ... }:
      {
        networking.hostName = lib.mkForce host.name;
      };
  };
}
