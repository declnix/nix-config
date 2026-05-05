{
  den,
  lib,
  ...
}:
let
  fwd = {
    host,
    user,
  }:
    den.provides.forward {
      each = lib.singleton true;
      fromClass = _: "zsh";
      intoClass = _: host.class;
      intoPath = _: [
        "hjem"
        "users"
        user.userName
      ];
      fromAspect = _: {
        zsh = den.lib.zsh.module user.aspect { inherit host user; };
      };
    };
in
{
  den.lib.zsh.module = zshAspect: ctx: { pkgs, ... }: let
    toUsers =
      if ctx ? host
      then ctx.host.aspect.provides.to-users or { }
      else { };
    toUser =
      if ctx ? host && ctx ? user
      then ctx.host.aspect.provides.${ctx.user.aspect.name} or { }
      else { };
    toHosts =
      if ctx ? user
      then ctx.user.aspect.provides.to-hosts or { }
      else { };
    zshResolved = den.lib.aspects.resolve "zsh" {
      includes = [
        den.aspects.zsh
        (den.lib.parametric.fixedTo ctx zshAspect)
        toUsers
        toUser
        toHosts
      ];
    };
    zshConfig =
      (lib.evalModules {
        modules = [
          {
            options.initConfig = lib.mkOption {
              type = lib.types.lines;
              default = "";
            };
            config._module.freeformType = lib.types.lazyAttrsOf lib.types.anything;
          }
          zshResolved
        ];
        specialArgs = {
          inherit pkgs lib;
        };
      }).config;
  in
  {
    rum.programs.zsh = { enable = true; } // builtins.removeAttrs zshConfig [ "_module" ];
  };

  den.ctx.user.includes = [ fwd ];

  den.provides.zsh = den.lib.parametric.exactly {
    includes = [ den.aspects.zsh ];
  };
}
