{ pkgs, ... }:
{
  programs = {
    git.enable = true;

    zsh = {
      enable = true;
      enableCompletion = true;

      oh-my-zsh = {
        enable = true;
        plugins = [ "git" ];
        theme = "robbyrussell";
      };
      plugins = [
        {
          name = "zsh-fzf-history-search";
          src = pkgs.zsh-fzf-history-search;
        }
      ];
    };
  };

  home.stateVersion = "25.11";
}
