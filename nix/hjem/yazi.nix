{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib.modules) mkAfter mkIf;
  inherit (lib.options) mkEnableOption mkPackageOption;

  cfg = config.rum.programs.yazi;
in {
  options.rum.programs.yazi = {
    enable = mkEnableOption "yazi";
    package = mkPackageOption pkgs "yazi" {nullable = true;};
    integrations.zsh.enable = mkEnableOption "yazi shell cd integration in zsh";
  };

  config = mkIf cfg.enable {
    packages = mkIf (cfg.package != null) [cfg.package];

    rum.programs.zsh.initConfig = mkIf cfg.integrations.zsh.enable (mkAfter ''
      function y() {
        local tmp="$(mktemp -t yazi-cwd.XXXXXX)"
        yazi "$@" --cwd-file="$tmp"
        if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
          cd -- "$cwd"
        fi
        rm -f -- "$tmp"
      }
    '');
  };
}
