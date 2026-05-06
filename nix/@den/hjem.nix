{
  den,
  inputs,
  lib,
  ...
}:
{
  flake-file.inputs = {
    dag.url = "github:denful/dag";
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

  den.default.nixos.hjem.extraModules = [
    # Wrapper for local hjem modules with inputs forwarding
    (import ../hjem/default.nix { inherit inputs lib; })
    inputs.hjem-impure.hjemModules.default
    inputs.hjem-rum.hjemModules.default
  ];

  den.default.hjem = {
    impure.enable = true;
  };

  den.schema.user.classes = lib.mkDefault [
    "hjem"
  ];
}
