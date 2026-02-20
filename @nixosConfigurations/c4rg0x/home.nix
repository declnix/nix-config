{ pkgs, ... }:
{
  programs = {
    git = {
      enable = true;
      extraConfig = {
        credential.helper = "/mnt/c/Program\\ Files/Git/mingw64/bin/git-credential-manager.exe";
      };
    };

    zsh = {
      enable = true;
      enableCompletion = true;
      
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      
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
        {
          name = "fzf-tab";
          src = pkgs.fetchFromGitHub {
            owner = "Aloxaf";
            repo = "fzf-tab";
            rev = "v1.2.0";
            sha256 = "sha256-q26XVS/LcyZPRqDNwKKA9exgBByE0muyuNb0Bbar2lY=";
          };
        }
      ];
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

  home.packages = with pkgs; [
    devbox
    claude-code
  ];

  home.stateVersion = "25.11";
}
