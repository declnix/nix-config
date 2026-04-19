{
  inputs,
  den,
  ...
}:
{
  perSystem =
    { pkgs, ... }:
    {
      devShells.default = pkgs.mkShell {
        packages = [
          pkgs.nixfmt
          pkgs.just
        ];
      };
      formatter = pkgs.nixfmt;
    };

  imports = [
    (inputs.flake-file.flakeModules.dendritic or { })
    (inputs.den.flakeModules.dendritic or { })
  ];

  _module.args.__findFile = den.lib.__findFile;
}
