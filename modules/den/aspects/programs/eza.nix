{
  den.aspects.programs.provides.eza = {
    hjem =
      { pkgs, ... }:
      {
        rum.programs.eza = {
          enable = true;
        };
      };
  };
}
