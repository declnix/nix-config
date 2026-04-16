{ den, ... }:
{
    den.aspects.bl1ndsp0t.provides.declnix = {
    hjem =
      { ... }:
      {
        alacritty.enable = true;
        alacritty.extraConfig = ''
          [window]
          decorations = "None"
        '';
      };
  };
}
