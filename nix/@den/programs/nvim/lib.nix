{
  den,
  lib,
  inputs,
  ...
}:
{
  den.lib.nvim.package =
    pkgs: vimAspect: ctx:
    (inputs.nvf.lib.neovimConfiguration {
      inherit pkgs;
      modules = [ (den.lib.nvim.module vimAspect ctx) ];
    }).neovim;

  den.lib.nvim.module =
    vimAspect: ctx:
    let
      vimClass =
        { class, aspect-chain }:
        den._.forward {
          each = lib.singleton true;
          fromClass = _: "vim";
          intoClass = _: "nvf";
          intoPath = _: [ "vim" ];
          fromAspect = _: lib.head aspect-chain;
          adaptArgs = lib.id;
        };

      aspect = den.lib.parametric.fixedTo ctx {
        includes = [
          vimClass
          vimAspect
        ];
      };
    in
    den.lib.aspects.resolve "nvf" aspect;
}
