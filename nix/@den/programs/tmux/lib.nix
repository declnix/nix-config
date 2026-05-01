{
  den,
  lib,
  inputs,
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
        hjem =
          { pkgs, ... }:
          {
            packages = [ pkgs.tmux ];
            files.".config/tmux/tmux.conf".text = den.lib.tmux.package pkgs user.aspect { inherit host user; };
          };
      };
    };
in
{
  den.lib.tmux.package =
    pkgs: tmuxAspect: ctx:
    inputs.ntf.lib.tmux.tmuxConfiguration {
      modules = [ (den.lib.tmux.module tmuxAspect ctx) ];
    };

  den.lib.tmux.module =
    tmuxAspect: ctx:
    let
      toUsers = if ctx ? host then ctx.host.aspect.provides.to-users or { } else { };
      toUser =
        if ctx ? host && ctx ? user then ctx.host.aspect.provides.${ctx.user.aspect.name} or { } else { };
      toHosts = if ctx ? user then ctx.user.aspect.provides.to-hosts or { } else { };
      resolved = den.lib.aspects.resolve "tmux" {
        includes = [
          den.aspects.tmux
          (den.lib.parametric.fixedTo ctx tmuxAspect)
          toUsers
          toUser
          toHosts
        ];
      };
    in
    {
      tmux = resolved;
    };

  den.ctx.user.includes = [ fwd ];

  den.provides.tmux = den.lib.parametric.exactly {
    includes = [ den.aspects.tmux ];
  };
}
