{ pkgs, ... }: {
  programs = {
    git = {
      enable = true;
      extraConfig = {
        credential.helper =
          "/mnt/c/Program\\ Files/Git/mingw64/bin/git-credential-manager.exe";
      };
    };

    zsh = {
      enable = true;
      enableCompletion = true;
      oh-my-zsh = {
        enable = true;
        plugins = [ "git" ];
        theme = "robbyrussell";
      };
    };

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    fzf.enable = true;
    ripgrep.enable = true;
    bat.enable = true;

    eza = {
      enable = true;
      enableZshIntegration = true;
    };
  };

  home.packages = with pkgs; [ devbox claude-code ];

  home.stateVersion = "25.11";
}
