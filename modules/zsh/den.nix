{
  lib,
  den,
  ...
}:
let
  zshForward =
    { user, host }:
    den.batteries.forward {
      each = lib.singleton user;
      fromClass = _: "zsh";
      intoClass = _: "hjem";
      intoPath = _: [
        "flakeAdapters"
        "zef"
      ];
      fromAspect = u: u.aspect;
      adaptArgs = args: { inherit (args) pkgs; };
    };
in
{
  den.schema.user.includes = [ zshForward ];
}
