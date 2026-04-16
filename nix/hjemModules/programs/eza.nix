{
  lib,
  config,
  pkgs,
  ...
}:
let
  inherit (lib.modules) mkIf;
  inherit (lib.options) mkEnableOption mkPackageOption;

  cfg = config.extraRum.programs.eza;
in
{
  options.extraRum.programs.eza = {
    enable = mkEnableOption "eza";
    package = mkPackageOption pkgs "eza" { nullable = true; };
    integrations.zsh.enable = mkEnableOption "eza aliases in zsh";
  };

  config = mkIf cfg.enable {
    packages = mkIf (cfg.package != null) [ cfg.package ];

    zsh.initConfig = mkIf cfg.integrations.zsh.enable ''
      alias ls='${lib.meta.getExe cfg.package} --icons'
      alias ll='${lib.meta.getExe cfg.package} -l --icons --git'
      alias la='${lib.meta.getExe cfg.package} -la --icons --git'
      alias tree='${lib.meta.getExe cfg.package} --tree --icons'
    '';
  };
}
