{ den, pkgs, ... }:
{
  den.aspects = {
    console = {
      includes = with den.aspects; [ zsh tmux ];
      hjem = { pkgs, ... }: {
        rum.programs.bat = { enable = true; integrations.zsh.enable = true; };
        rum.programs.eza = { enable = true; integrations.zsh.enable = true; };
        rum.programs.fzf = { enable = true; integrations.zsh.enable = true; };
        rum.programs.zoxide = { enable = true; integrations.zsh.enable = true; };
      };
    };

    development = {
      hjem = { pkgs, ... }: {
        packages = with pkgs; [ ripgrep devbox ];
        rum.programs = {
          direnv = { enable = true; integrations.zsh.enable = true; };
          git.enable = true;
        };
      };
      includes = with den.aspects; [ console nvim ];
    };
  };
}
