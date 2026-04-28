{
  den,
  lib,
  inputs,
  ...
}:
{
  den.lib.tmux.package =
    pkgs: tmuxAspect: ctx:
    (den.lib.tmux.module tmuxAspect ctx).config.finalConfig;

  den.lib.tmux.module =
    tmuxAspect: ctx:
    inputs.ntf.lib.tmux.tmuxConfiguration {
      modules = [
        tmuxAspect.config or { }
      ];
    };
}
