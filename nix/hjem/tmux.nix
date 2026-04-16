{ config, pkgs, lib, ... }:
{
  options.tmux = {
    mouse = lib.mkEnableOption "mouse support" // {
      default = true;
    };
    baseIndex = lib.mkOption {
      type = lib.types.int;
      default = 1;
    };
    extraConfig = lib.mkOption {
      type = lib.types.lines;
      default = "";
    };
  };
  config.files.".config/tmux/tmux.conf".text = ''
    ${lib.optionalString config.tmux.mouse "set -g mouse on"}
    set -g base-index ${toString config.tmux.baseIndex}
    ${config.tmux.extraConfig}
  '';
  config.packages = [ pkgs.tmux ];
}
