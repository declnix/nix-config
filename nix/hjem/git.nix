{
  config,
  pkgs,
  lib,
  ...
}:
{
  options.git = {
    enable = lib.mkEnableOption "git";
    extraConfig = lib.mkOption {
      type = lib.types.lines;
      default = "";
    };
  };
  config = lib.mkIf config.git.enable {
    packages = [ pkgs.git ];
    files.".config/git/config".text = config.git.extraConfig;
  };
}
