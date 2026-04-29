{
  den,
  lib,
  inputs,
  ...
}:
{
  den.lib.zsh.module =
    zshAspect: ctx:
    let
      zshClass =
        { class, aspect-chain }:
        den._.forward {
          each = lib.singleton true;
          fromClass = _: "zsh";
          intoClass = _: "";
          intoPath = _: [ ];
          fromAspect = _: lib.head aspect-chain;
          adaptArgs = lib.id;
        };

      zshFromProvidesToUsers = { class, aspect-chain }:
        if class == "zsh" then
          {
            includes = lib.concatMap (aspect:
              let toUsers = if builtins.isAttrs aspect then aspect.provides.to-users or { } else { };
              in lib.optional (toUsers ? zsh) ({ class, aspect-chain }: { zsh = toUsers.zsh; })
            ) (lib.attrValues den.aspects);
          }
        else { };

      aspect = den.lib.parametric.fixedTo ctx {
        includes = [
          zshClass
          zshAspect
          zshFromProvidesToUsers
        ];
      };
    in
    den.lib.aspects.resolve "" aspect;

  den.lib.zsh.package =
    pkgs: zshAspect: ctx:
    inputs.nzf.lib.zsh.zshConfiguration {
      modules = [ (den.lib.zsh.module zshAspect ctx) ];
      specialArgs = {
        lib = inputs.nzf.lib;
      };
    };
}