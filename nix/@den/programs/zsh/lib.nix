{ den, lib, inputs, ... }:
let
  fwd =
    { host, user }:
    den.provides.forward {
      each = lib.singleton true;
      fromClass = _: "zsh";
      intoClass = _: host.class;
      intoPath = _: [ "hjem" "users" user.userName ];
      fromAspect = _: {
        zsh = { pkgs, ... }: {
          rum.programs.zsh = {
            enable = true;
            initConfig = den.lib.zsh.package pkgs user.aspect { inherit host user; };
          };
        };
      };
    };
in
{
  den.lib.zsh.package =
    pkgs: zshAspect: ctx:
    inputs.nzf.lib.zsh.zshConfiguration {
      modules = [ (den.lib.zsh.module zshAspect ctx) ];
      specialArgs = {
        lib = inputs.nzf.lib;
      };
    };

  den.lib.zsh.module = zshAspect: ctx:
    let
      toUsers = if ctx ? host then ctx.host.aspect.provides.to-users or { } else { };
      toUser = if ctx ? host && ctx ? user then ctx.host.aspect.provides.${ctx.user.aspect.name} or { } else { };
      toHosts = if ctx ? user then ctx.user.aspect.provides.to-hosts or { } else { };
    in
    den.lib.aspects.resolve "zsh" {
      includes = [
        den.aspects.zsh
        (den.lib.parametric.fixedTo ctx zshAspect)
        toUsers
        toUser
        toHosts
      ];
    };

  den.ctx.user.includes = [ fwd ];

  den.provides.zsh = den.lib.parametric.exactly {
    includes = [ den.aspects.zsh ];
  };
}