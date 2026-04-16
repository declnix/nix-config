{
  lib,
  config,
  pkgs,
  ...
}:
let
  inherit (lib.modules) mkIf;
  inherit (lib.options) mkEnableOption mkPackageOption;

  cfg = config.extraRum.programs.bat;
in
{
  options.extraRum.programs.bat = {
    enable = mkEnableOption "bat";
    package = mkPackageOption pkgs "bat" { nullable = true; };
    integrations.zsh.enable = mkEnableOption "bat alias for cat in zsh";
  };

  config = mkIf cfg.enable {
    packages = mkIf (cfg.package != null) [ cfg.package ];

    zsh.initConfig = mkIf cfg.integrations.zsh.enable ''
      alias cat='${lib.meta.getExe cfg.package}'
    '';
  };
}
