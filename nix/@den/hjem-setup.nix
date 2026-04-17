{ inputs, ... }:
let
  hjemModules = builtins.attrValues (
    builtins.mapAttrs (name: _: ../hjem/${name}) (builtins.readDir ../hjem)
  );
in
{
  den.default.nixos =
    { ... }:
    {
      hjem.extraModules = hjemModules ++ [
        inputs.hjem-impure.hjemModules.default
        inputs.hjem-rum.hjemModules.default
      ];
    };

  den.default.hjem =
    { ... }:
    {
      impure.enable = true;
    };

  flake-file.inputs = {
    hjem = {
      url = "github:feel-co/hjem";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hjem-impure = {
      url = "github:Rexcrazy804/hjem-impure";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.hjem.follows = "hjem";
    };
    hjem-rum = {
      url = "github:snugnug/hjem-rum";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.hjem.follows = "hjem";
    };
  };
}
