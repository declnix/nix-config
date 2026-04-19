{ den, ... }:
{
  den.aspects.z4c1sz3.provides.declnix = {
    hjem =
      { pkgs, ... }:
      {
        packages = with pkgs; [
          swaylock
          swayidle
        ];
        files.".config/swaylock/config".text = ''
          color=000000
          show-failed-attempts
        '';
      };
  };
}
