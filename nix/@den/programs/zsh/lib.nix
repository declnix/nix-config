{
  den,
  lib,
  inputs,
  ...
}:
{
  den.lib.zsh.package =
    pkgs: zshAspect: ctx:
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

      resolved = den.lib.aspects.resolve "" aspect;
    in
    inputs.nzf.lib.zsh.zshConfiguration {
      modules = [ resolved ];
      specialArgs = {
        lib = inputs.nzf.lib;
      };
    };
}
