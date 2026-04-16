{
  config,
  pkgs,
  lib,
  ...
}:
{
  options.extraRum.programs.waybar = {
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
  config = lib.mkIf config.extraRum.programs.waybar.enable {
    packages = [ pkgs.waybar ];
    files.".config/waybar/config".text = config.extraRum.programs.waybar.extraConfig;
    files.".config/waybar/style.css".text = config.extraRum.programs.waybar.extraStyle;
  };
}
