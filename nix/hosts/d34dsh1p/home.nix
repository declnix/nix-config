{ ... }:
{
  home.stateVersion = "24.05";

  programs.git = {
    extraConfig = {
      credential = {
        helper = "/mnt/c/Program\\ Files/Git/mingw64/bin/git-credential-manager.exe";
      };
    };

    enable = true;
  };
}
