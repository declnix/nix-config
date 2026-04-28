{
  den,
  lib,
  inputs,
  ...
}:
{
  den.lib.tmux.package =
    pkgs: tmuxAspect: ctx:
    let
      tmuxClass =
        { class, aspect-chain }:
        den._.forward {
          each = lib.singleton true;
          fromClass = _: "tmux";
          intoClass = _: "";
          intoPath = _: [ ];
          fromAspect = _: lib.head aspect-chain;
          adaptArgs = lib.id;
        };

      aspect = den.lib.parametric.fixedTo ctx {
        includes = [
          tmuxClass
          tmuxAspect
        ];
      };

      resolved = den.lib.aspects.resolve "" aspect;
    in
    inputs.ntf.lib.tmux.tmuxConfiguration {
      modules = [ resolved ];
    };
}
