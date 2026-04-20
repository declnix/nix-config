{
  lib,
  config,
  ...
}: let
  inherit (lib.modules) mkAfter mkIf;
  inherit (lib.options) mkEnableOption;

  cfg = config.rum.programs.yazi;
in {
  options.rum.programs.yazi.integrations.zsh.enable = mkEnableOption "yazi shell cd integration in zsh";

  config = mkIf (cfg.enable && cfg.integrations.zsh.enable) {
    rum.programs.zsh.initConfig = mkAfter ''
      function y() {
        local tmp="$(mktemp -t yazi-cwd.XXXXXX)"
        yazi "$@" --cwd-file="$tmp"
        if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
          cd -- "$cwd"
        fi
        rm -f -- "$tmp"
      }
    '';
  };
}
