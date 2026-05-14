{ den, ... }:
{
  den.aspects.console = {
    includes = with den.aspects; [
      zsh
      tmux
    ];

    hjem =
      { pkgs, ... }:
      {
        rum.programs.bat = {
          enable = true;
          integrations.zsh.enable = true;
        };
        rum.programs.eza = {
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
