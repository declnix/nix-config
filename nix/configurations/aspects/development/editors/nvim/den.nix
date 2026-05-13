{
  lib,
  den,
  ...
}:
let
  nvimForward =
    { host, user }:
    den.batteries.forward {
      each = lib.singleton user;
      fromClass = _: "vim";
      intoClass = _: "hjem";
      intoPath = _: [
        "nvf"
        "vim"
      ];
      fromAspect = u: u.aspect;
      adaptArgs = args: { inherit (args) pkgs; };
    };
in
{
  den.schema.user.includes = [ nvimForward ];
}
