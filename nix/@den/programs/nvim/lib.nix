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
          let
            nvimModule = den.lib.nvim.module user.aspect { inherit host user; };
            nvimResult = inputs.nvf.lib.neovimConfiguration {
              inherit pkgs;
              modules = [ nvimModule ];
            };
            nvim = pkgs.runCommand "nvim" { nativeBuildInputs = [ pkgs.makeWrapper ]; } ''
              makeWrapper ${nvimResult.neovim}/bin/nvim $out/bin/nvim --unset VIMINIT
            '';
          in
          {
            packages = [ nvim ];
            files.".config/nvf/init.lua".text = nvimResult.config.vim.builtLuaConfigRC;
            environment.sessionVariables.EDITOR = "nvim";
          };
      };
    };
in
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
            { _module.freeformType = lib.types.lazyAttrsOf lib.types.unspecified; }
            vimResolved
          ];
        }).config;
    in
    {
      vim = builtins.removeAttrs vimConfig [ "_module" ];
    };

  den.ctx.user.includes = [ fwd ];

  den.provides.nvim = den.lib.parametric.exactly {
    includes = [ den.aspects.nvim ];
  };
}
