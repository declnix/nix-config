{
  lib,
  den,
  inputs,
  ...
}:
{
  den.lib.nvim.module = vimAspect: ctx: {
    nvim = {
      enable = true;
      inputs = { inherit (inputs) nvf; };
      vimModules = [ (den.lib.nvim.vimModule vimAspect ctx) ];
    };
  };

  den.lib.nvim.vimModule =
    vimAspect: ctx:
    { pkgs, ... }:
    let
      toUsers = if ctx ? host then ctx.host.aspect.provides.to-users or { } else { };
      toUser =
        if ctx ? host && ctx ? user then ctx.host.aspect.provides.${ctx.user.aspect.name} or { } else { };
      toHosts = if ctx ? user then ctx.user.aspect.provides.to-hosts or { } else { };
      vimResolved = den.lib.aspects.resolve "vim" {
        includes = [
          den.aspects.nvim
          (den.lib.parametric.fixedTo ctx vimAspect)
          toUsers
          toUser
          toHosts
        ];
      };
      vimConfig =
        (lib.evalModules {
          modules = [
            { config._module.freeformType = lib.types.lazyAttrsOf lib.types.anything; }
            vimResolved
          ];
          specialArgs = { inherit pkgs; };
        }).config;
    in
    {
      vim = builtins.removeAttrs vimConfig [ "_module" ];
    };

  den.lib.nvim.package =
    pkgs: vimAspect: ctx:
    (inputs.nvf.lib.neovimConfiguration {
      inherit pkgs;
      modules = [ (den.lib.nvim.vimModule vimAspect ctx) ];
    }).neovim;

  den.ctx.user.includes = [
    (
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
          hjem = den.lib.nvim.module user.aspect { inherit host user; };
        };
      }
    )
  ];
  den.schema.user.classes = lib.mkAfter [ "vim" ];

  den.provides.nvim = den.lib.parametric.exactly {
    includes = [ den.aspects.nvim ];
  };

}
