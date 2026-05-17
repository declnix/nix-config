{
  lib,
  den,
  ...
}:
let
  tmuxForward =
    { host, user }:
    den.batteries.forward {
      each = lib.singleton user;
      fromClass = _: "tmux";
      intoClass = _: "hjem";
      intoPath = _: [
        "flakeAdapters"
        "tmf"
      ];
      fromAspect = u: u.aspect;
      adaptArgs = args: { inherit (args) config; };
    };
in
{
  den.schema.user.includes = [ tmuxForward ];
}
