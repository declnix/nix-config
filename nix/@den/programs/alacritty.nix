{ den, ... }:
{
  den.aspects.alacritty = {
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
