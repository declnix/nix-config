{ config, pkgs, lib, ... }:
{
  options.alacritty = {
    enable = lib.mkEnableOption "alacritty";
    extraConfig = lib.mkOption {
      type = lib.types.lines;
      default = "";
    };
  };
  config = lib.mkIf config.alacritty.enable {
    packages = [ pkgs.alacritty ];
    files.".config/alacritty/alacritty.toml".text = config.alacritty.extraConfig;
  };
}
