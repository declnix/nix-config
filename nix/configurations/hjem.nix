{
  den,
  inputs,
  lib,
  ...
}:
{
  den.default.nixos.hjem.extraModules = [
    {
      _module.args.dag = inputs.dag.lib { inherit lib; };
      _module.args.inputs = inputs;
    }
  ]
  ++ [
    inputs.hjem-impure.hjemModules.default
    inputs.hjem-rum.hjemModules.default
  ]
  ++ (inputs.import-tree ../hjemModules).imports;
  den.default.hjem = {
    impure.enable = true;
  };

  den.schema.user.classes = [ "hjem" ];

  den.schema.host.hjem.enable = true;

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
}
