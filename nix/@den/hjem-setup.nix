{
  den,
  inputs,
  lib,
  ...
}: let
  hjemModules = builtins.attrValues (
    builtins.mapAttrs (name: _: ../hjem/${name}) (builtins.readDir ../hjem)
  );
in {
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

  den.default.nixos.hjem.extraModules =
    hjemModules
    ++ [
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
