{
  den,
  lib,
  inputs,
  ...
}:
{
  den.lib.zsh.package =
    pkgs: zshAspect: ctx:
    (den.lib.zsh.module zshAspect ctx).config.finalConfig;

  den.lib.zsh.module =
    zshAspect: ctx:
    inputs.nzf.lib.zsh.zshConfiguration {
      modules = [
        zshAspect.config or { }
      ];
      specialArgs = {
        lib = inputs.nzf.lib;
      };
    };
}
