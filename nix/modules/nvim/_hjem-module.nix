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
    enable = lib.mkEnableOption "nvim wrapper";
    inputs = mkOption {
      type = types.attrs;
      default = { };
    };
    vimModules = mkOption {
      type = types.listOf types.deferredModule;
      default = [ ];
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
