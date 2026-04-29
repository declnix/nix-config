{
  den,
  lib,
  inputs,
  ...
}:
{
  den.lib.tmux.package =
    pkgs: tmuxAspect: ctx:
    inputs.ntf.lib.tmux.tmuxConfiguration {
      modules = [ (den.lib.tmux.module tmuxAspect ctx) ];
    };

  den.lib.tmux.module =
    tmuxAspect: ctx:
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
    in
    den.lib.aspects.resolve "" aspect;
}
