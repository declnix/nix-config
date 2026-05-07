{ lib, ... }:
{
  den.default.nixos.hjem.extraModules = lib.mkAfter [
    ./_/hjem-module.nix
  ];
}
