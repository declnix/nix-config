{
  den.aspects.fzf = {
    hjem =
      { pkgs, ... }:
      {
        rum.programs.fzf = {
          enable = true;
          integrations.zsh.enable = true;
        };
      };
  };
}
