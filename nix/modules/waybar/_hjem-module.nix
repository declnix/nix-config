{
  config,
  pkgs,
  lib,
  ...
}:
{
  options.waybar = {
    enable = lib.mkEnableOption "waybar";
    extraConfig = lib.mkOption {
      type = lib.types.lines;
      default = "";
    };
    extraStyle = lib.mkOption {
      type = lib.types.lines;
      default = "";
    };
  };
  config = lib.mkIf config.waybar.enable {
    packages = [ pkgs.waybar ];
    files.".config/waybar/config".text = config.waybar.extraConfig;
    files.".config/waybar/style.css".text = config.waybar.extraStyle;
  };
}
