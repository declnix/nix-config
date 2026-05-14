{
  den,
  inputs,
  lib,
  ...
}:
{
  den = {
    default = {
      nixos.hjem.extraModules =
        let
          localFiles = (inputs.import-tree.withLib lib).leafs ./_extraModules;

          disabledFromRum =
            let
              toRumPath =
                p:
                let
                  relPath = lib.removePrefix (toString ./_extraModules + "/") (toString p);
                in
                "${inputs.hjem-rum}/modules/${relPath}";
            in
            builtins.filter builtins.pathExists (map toRumPath localFiles);
        in
        [
          {
            _module.args = {
              dag = inputs.dag.lib { inherit lib; };
              inherit inputs;
            };
            disabledModules = disabledFromRum;
          }
          inputs.hjem-impure.hjemModules.default
          inputs.hjem-rum.hjemModules.default
        ]
        ++ localFiles;

      hjem.impure.enable = true;
    };

    schema = {
      user.classes = [ "hjem" ];
      host.hjem.enable = true;
    };
  };

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
