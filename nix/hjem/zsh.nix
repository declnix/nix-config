{ config, pkgs, lib, ... }:
{
  options.zsh = {
    enable = lib.mkEnableOption "zsh";
    extraConfig = lib.mkOption {
      type = lib.types.lines;
      default = "";
    };
  };
  config = lib.mkIf config.zsh.enable {
    packages = [ pkgs.zsh ];
    files.".zshrc".text = config.zsh.extraConfig;
  };
}
