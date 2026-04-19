{ den, ... }:
{
  den.aspects.dev-tools = {
    hjem =
      { pkgs, ... }:
      {
        packages = with pkgs; [ ripgrep ];
        rum.programs.direnv = {
          enable = true;
          integrations.zsh.enable = true;
        };
      };

    includes = with den.aspects; [
      zsh
      tmux
      git
      nvim
      yazi
      lazygit
    ];
  };
}
