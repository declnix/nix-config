{ den, inputs, lib, ... }:
let
  hjemModules = builtins.attrValues (
    builtins.mapAttrs (name: _: ../hjem/${name}) (builtins.readDir ../hjem)
  );
in
{
  den.default.includes = [
    den._.mutual-provider
    den._.hostname
    den._.define-user
  ]
  ++ (with den.aspects; [ nix utils ]);

  den.default.nixos = {
    system.stateVersion = "25.11";
    hjem.extraModules = hjemModules ++ [
      inputs.hjem-impure.hjemModules.default
      inputs.hjem-rum.hjemModules.default
    ];
  };

  den.default.hjem = {
    impure.enable = true;
  };

  den.schema.user.classes = lib.mkDefault [
    "hjem"
  ];
}
