{
  lib,
  config,
  pkgs,
  ...
}:
let
  inherit (lib.modules) mkIf;
  inherit (lib.options) mkEnableOption mkPackageOption;

  cfg = config.rum.programs.yazi;
in
{
  options.rum.programs.yazi = {
    enable = mkEnableOption "yazi";
    package = mkPackageOption pkgs "yazi" { nullable = true; };
    integrations.zsh.enable = mkEnableOption "yazi alias in zsh";
  };

  config = mkIf cfg.enable {
    packages = mkIf (cfg.package != null) [ cfg.package ];

    rum.programs.zsh.initConfig = mkIf cfg.integrations.zsh.enable ''
      alias y='${lib.meta.getExe cfg.package}'
    '';
  };
}
