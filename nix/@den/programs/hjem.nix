{ ... }:
let
  hjemModules = builtins.attrValues (
    builtins.mapAttrs (name: _: ../../hjem/${name}) (builtins.readDir ../../hjem)
  );
in
{
  den.default.nixos =
    { ... }:
    {
      hjem.extraModules = hjemModules;
    };
}
