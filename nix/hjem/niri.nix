{
  config,
  pkgs,
  lib,
  ...
}:
{
  options.niri = {
    enable = lib.mkEnableOption "niri";
    extraConfig = lib.mkOption {
      type = lib.types.lines;
      default = "";
    };
  };
  config = lib.mkIf config.niri.enable {
    packages = [ pkgs.niri ];
    files.".config/niri/config.kdl".text = config.niri.extraConfig;
  };
}
