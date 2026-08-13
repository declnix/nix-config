{ ... }:
{
  den.aspects.kr7va = {
    provides.declnix.nixos = { pkgs, ... }: {
      programs.labwc.enable = true;

      services.greetd = {
        enable = true;
        settings = {
          default_session = {
            command = "${pkgs.labwc}/bin/labwc";
            user = "declnix";
          };
        };
      };
    };
  };
}
