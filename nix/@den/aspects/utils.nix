{ den, ... }:
{
  den.aspects.utils = {
    hjem =
      { pkgs, ... }:
      {
        packages = with pkgs; [
          bat
        ];
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
