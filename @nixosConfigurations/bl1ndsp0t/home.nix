{ ... }:
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
    };
  };

  home.stateVersion = "25.11";
}
