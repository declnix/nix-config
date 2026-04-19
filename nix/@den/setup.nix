{
  inputs,
  den,
  lib,
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

  den.default.includes = [
    den._.mutual-provider
    den._.hostname
    den._.define-user
  ]
  ++ (with den.aspects; [ nix utils ]);

  den.default = {
    nixos.system.stateVersion = "25.11";
  };

  den.schema.user.classes = lib.mkDefault [
    "hjem"
  ];

  imports = [
    (inputs.flake-file.flakeModules.dendritic or { })
    (inputs.den.flakeModules.dendritic or { })
  ];

  _module.args.__findFile = den.lib.__findFile;
}
