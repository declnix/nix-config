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

  cfg = config.rum.programs.eza;
in
{
  options.rum.programs.eza = {
    enable = mkEnableOption "eza";
    package = mkPackageOption pkgs "eza" { nullable = true; };
    integrations.zsh.enable = mkEnableOption "eza aliases in zsh";
  };

  config = mkIf cfg.enable {
    packages = mkIf (cfg.package != null) [ cfg.package ];

    rum.programs.zsh.initConfig = mkIf cfg.integrations.zsh.enable (mkAfter ''
      alias ls='${getExe cfg.package} --icons'
      alias ll='${getExe cfg.package} -l --icons --git'
      alias la='${getExe cfg.package} -la --icons --git'
      alias tree='${getExe cfg.package} --tree --icons'
    '');
  };
}
