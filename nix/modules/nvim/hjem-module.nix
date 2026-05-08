{
  lib,
  config,
  pkgs,
  ...
}:
{
  den.default.nixos.hjem.extraModules = lib.mkAfter [
    (
      {
        lib,
        config,
        pkgs,
        ...
      }:
      let
        inherit (lib) mkOption types mkIf;
        cfg = config.nvim;
      in
      {
        options.nvim = {
          enable = lib.mkEnableOption "nvim via nvf";
          inputs = mkOption {
            type = types.attrs;
            default = { };
            description = "Flake inputs passed from den aspect (must include nvf)";
          };
          vimModules = mkOption {
            type = types.listOf types.deferredModule;
            default = [ ];
            description = "nvf modules to pass to neovimConfiguration";
          };
        };

        config = mkIf cfg.enable (
          let
            nvimResult = cfg.inputs.nvf.lib.neovimConfiguration {
              inherit pkgs;
              modules = cfg.vimModules;
            };
            nvim = pkgs.runCommand "nvim" { nativeBuildInputs = [ pkgs.makeWrapper ]; } ''
              makeWrapper ${nvimResult.neovim}/bin/nvim $out/bin/nvim --unset VIMINIT
            '';
          in
          {
            packages = [ nvim ];
            files.".config/nvf/init.lua".text = nvimResult.config.vim.builtLuaConfigRC;
            environment.sessionVariables.EDITOR = "nvim";
          }
        );
      }
    )
  ];
}
