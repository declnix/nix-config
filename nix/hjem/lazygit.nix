{
  lib,
  pkgs,
  config,
  ...
}:
let
  inherit (lib.meta) getExe;
  inherit (lib.modules) mkAfter mkIf;
  inherit (lib.options) mkEnableOption mkPackageOption;

  cfg = config.rum.programs.lazygit;
in
{
  options.rum.programs.lazygit = {
    enable = mkEnableOption "lazygit";
    package = mkPackageOption pkgs "lazygit" { nullable = true; };
    integrations.zsh.enable = mkEnableOption "lazygit lg alias in zsh";
  };

  config = mkIf cfg.enable {
    packages = mkIf (cfg.package != null) [ cfg.package ];

    rum.programs.zsh.initConfig = mkIf cfg.integrations.zsh.enable (mkAfter ''
      alias lg='${getExe cfg.package}'
    '');
  };
}
