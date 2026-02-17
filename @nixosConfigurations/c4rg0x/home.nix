{ pkgs, ... }: {
  programs.git = {
    enable = true;
    extraConfig = {
      credential.helper =
        "/mnt/c/Program\\ Files/Git/mingw64/bin/git-credential-manager.exe";
    };
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.fzf.enable = true;
  programs.ripgrep.enable = true;
  programs.bat.enable = true;
  programs.eza = {
    enable = true;
    enableZshIntegration = true;
  };

  home.packages = with pkgs; [ devbox claude-code ];

  home.stateVersion = "25.11";
}
