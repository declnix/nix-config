{
  inputs,
  den,
  ...
}:
{
  flake-file.inputs.treefmt-nix = {
    url = "github:numtide/treefmt-nix";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  imports = [
    (inputs.flake-file.flakeModules.dendritic or { })
    (inputs.den.flakeModules.dendritic or { })
    inputs.treefmt-nix.flakeModule
  ];

  perSystem =
    { pkgs, ... }:
    {
      devShells.default = pkgs.mkShell {
        packages = [
          pkgs.just
        ];
      };

      treefmt = {
        projectRootFile = "flake.nix";
        programs.nixfmt.enable = true;
      };
    };

  _module.args.__findFile = den.lib.__findFile;
}
