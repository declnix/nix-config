{ den, ... }:
{
  den.aspects.utils = {
    hjem =
      { pkgs, ... }:
      {
        packages = with pkgs; [
          bat
          eza
        ];
        rum.programs.fzf = {
          enable = true;
          integrations.zsh.enable = true;
        };
        rum.programs.zoxide = {
          enable = true;
          integrations.zsh.enable = true;
        };
        rum.programs.zsh.initConfig = ''
          alias ls="${pkgs.eza}/bin/eza"
          alias ll="${pkgs.eza}/bin/eza -la"
          alias lt="${pkgs.eza}/bin/eza --tree"
        '';
      };

  };
}
