{
  den.aspects.kr7va.provides.declnix = {
    hjem =
      { ... }:
      {
        rum.desktops.niri.config = ''
          input {
            touchpad {
              tap
              natural-scroll
              scroll-method "two-finger"
            }
          }
        '';
      };

    nixos = {
      programs.niri.enable = true;
    };
  };
}