{
  lib,
  den,
  inputs,
  ...
}:
{
  den.lib.nvim.vimModule = vimAspect: ctx: { pkgs, ... }:
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

  den.schema.user.includes = [
    (
      { host, user }:
      {
        hjem.nvim = {
          enable = true;
          inputs = { inherit (inputs) nvf; };
          vimModules = [ (den.lib.nvim.vimModule user.aspect { inherit host user; }) ];
        };
      }
    )
  ];

}
