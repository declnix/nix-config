{
  lib,
  ...
}:
{
  den.default.nixos.hjem.extraModules = lib.mkAfter [
    ./_hjem-module.nix
  ];
}
