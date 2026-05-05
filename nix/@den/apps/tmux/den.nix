{
  den,
  lib,
  ...
}:
let
  fwd =
    { host, user }:
    den.provides.forward {
      each = lib.singleton true;
      fromClass = _: "hjem";
      intoClass = _: host.class;
      intoPath = _: [
        "hjem"
        "users"
        user.userName
      ];
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
          specialArgs = {
            inherit pkgs lib;
          };
        }).config;
    in
    {
      packages = [ pkgs.tmux ];
      files.".config/tmux/tmux.conf".text = tmuxConfig.initConfig;
    };

  den.ctx.user.includes = [ fwd ];

  den.provides.tmux = den.lib.parametric.exactly {
    includes = [ den.aspects.tmux ];
  };
}
