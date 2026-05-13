{ den, ... }:
{
  den.aspects.essentials = {
    hjem =
      { pkgs, ... }:
      {
        extraRum.programs.bat = {
          enable = true;
          integrations.zsh.enable = true;
        };
        extraRum.programs.eza = {
          enable = true;
          integrations.zsh.enable = true;
        };
        rum.programs.fzf = {
          enable = true;
          integrations.zsh.enable = true;
        };
        rum.programs.zoxide = {
          enable = true;
          integrations.zsh.enable = true;
        };
      };

  };
}
