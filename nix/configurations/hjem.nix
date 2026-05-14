{
  den,
  inputs,
  lib,
  ...
}:
let
  # Automatyczne wyłączanie modułów z hjem-rum, które mamy zdefiniowane lokalnie
  # Skanujemy folder ../hjemModules i mapujemy pliki na strukturę w hjem-rum/modules/
  disabledFromRum =
    let
      hjemModulesDir = ../hjemModules;
      
      # Rekurencyjne zbieranie plików .nix
      getFiles = dir:
        lib.mapAttrsToList (name: type:
          let path = dir + "/${name}"; in
          if type == "directory" then getFiles path
          else if lib.hasSuffix ".nix" name then [ path ]
          else [ ]
        ) (builtins.readDir dir);
      
      allLocalFiles = lib.flatten (getFiles hjemModulesDir);

      toRumPath = p:
        let
          relPath = lib.removePrefix (toString hjemModulesDir + "/") (toString p);
        in
        "${inputs.hjem-rum}/modules/${relPath}";
    in
    builtins.filter builtins.pathExists (map toRumPath allLocalFiles);
in
{
  den.default.nixos.hjem.extraModules =
    [
      {
        _module.args.dag = inputs.dag.lib { inherit lib; };
        _module.args.inputs = inputs;
        disabledModules = disabledFromRum;
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
