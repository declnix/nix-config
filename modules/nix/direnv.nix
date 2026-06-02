{
  den.aspects.direnv = {
    hjem =
      { pkgs, ... }:
      {
        rum.programs.direnv = {
          enable = true;
          integrations.zsh.enable = true;
        };
      };
  };
}
