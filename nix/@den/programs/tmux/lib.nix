{
  den,
  lib,
  inputs,
  ...
}:
{
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

      tmuxFromProvidesToUsers = { class, aspect-chain }:
        if class == "tmux" then
          {
            includes = lib.concatMap (aspect:
              let toUsers = if builtins.isAttrs aspect then aspect.provides.to-users or { } else { };
              in lib.optional (toUsers ? tmux) ({ class, aspect-chain }: { tmux = toUsers.tmux; })
            ) (lib.attrValues den.aspects);
          }
        else { };

      aspect = den.lib.parametric.fixedTo ctx {
        includes = [
          tmuxClass
          tmuxAspect
          tmuxFromProvidesToUsers
        ];
      };
    in
    den.lib.aspects.resolve "" aspect;

  den.lib.tmux.package =
    pkgs: tmuxAspect: ctx:
    inputs.ntf.lib.tmux.tmuxConfiguration {
      modules = [ (den.lib.tmux.module tmuxAspect ctx) ];
    };
}