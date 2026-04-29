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

      aspect = den.lib.parametric.fixedTo ctx {
        includes = [
          zshClass
          zshAspect
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
