{ lib, den, ... }:
let
  fwd =
    { host, user }:
    den.provides.forward {
      each = lib.singleton true;
      fromClass = _: "hjem";
      intoClass = _: host.class;
      intoPath = _: [ "hjem" "users" user.userName ];
      fromAspect = _: {
        hjem = den.lib.tmux.module user.aspect { inherit host user; };
      };
    };
in
{
  den.lib.tmux.module =
    tmuxAspect: ctx:
    { pkgs, ... }:
    let
      toUsers = if ctx ? host then ctx.host.aspect.provides.to-users or { } else { };
      toUser =
        if ctx ? host && ctx ? user then ctx.host.aspect.provides.${ctx.user.aspect.name} or { } else { };
      toHosts = if ctx ? user then ctx.user.aspect.provides.to-hosts or { } else { };
      tmuxResolved = den.lib.aspects.resolve "tmux" {
        includes = [
          den.aspects.tmux
          (den.lib.parametric.fixedTo ctx tmuxAspect)
          toUsers
          toUser
          toHosts
        ];
      };
      tmuxConfig =
        (lib.evalModules {
          modules = [
            {
              options.initConfig = lib.mkOption {
                type = lib.types.lines;
                default = "";
              };
              config._module.freeformType = lib.types.lazyAttrsOf lib.types.anything;
            }
            tmuxResolved
          ];
          specialArgs = { inherit pkgs lib; };
        }).config;
    in
    {
      tmux = {
        enable = true;
        initConfig = tmuxConfig.initConfig;
      };
    };

  den.ctx.user.includes = [ fwd ];

  den.aspects.tmux = {
    tmux =
      { pkgs, ... }:
      {
        initConfig = ''
          set -g mouse on
          set -g base-index 1
          set -g status-style "bg=default"
          set -g status-justify "centre"
          set -g status-left ""
          set -g status-right ""
          set -g window-status-format "#[fg=gray] #I:#W "
          set -g window-status-current-format "#[fg=white,bold] #I:#W "
          run-shell ${pkgs.tmuxPlugins.sensible.rtp}
          run-shell ${pkgs.tmuxPlugins.resurrect.rtp}
          run-shell ${pkgs.tmuxPlugins.continuum.rtp}
        '';
      };
  };

  den.provides.tmux = den.lib.parametric.exactly {
    includes = [ den.aspects.tmux ];
  };

  den.default.nixos.hjem.extraModules = lib.mkAfter [
    ./_/hjem-module.nix
  ];
}
