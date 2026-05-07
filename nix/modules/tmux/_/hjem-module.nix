{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) mkOption types mkIf;
  cfg = config.tmux;
in {
  options.tmux = {
    enable = lib.mkEnableOption "tmux wrapper";
    initConfig = mkOption {
      type = types.lines;
      default = "";
    };
  };

  config = mkIf cfg.enable {
    packages = [pkgs.tmux];
    files.".config/tmux/tmux.conf".text = cfg.initConfig;
  };
}
