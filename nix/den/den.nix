{ den, lib, ... }:
{
  den.default.includes = [
    den.batteries.mutual-provider
    den.batteries.hostname
    den.batteries.define-user
    den.batteries.inputs'
  ]
  ++ (with den.aspects; [
    nix
    essentials
  ]);

  den.default.nixos = {
    system.stateVersion = "25.11";
  };

  flake-file.inputs = {
    den.url = lib.mkDefault "github:denful/den";
  };
}
