{ lib, ... }:
{
  den.aspects.git = {
    hjem =
      { osConfig, ... }:
      {
        git.enable = true;
        git.extraConfig = lib.optionalString (osConfig.wsl.enable or false) ''
          [credential]
            helper = /mnt/c/Program\\ Files/Git/mingw64/bin/git-credential-manager.exe
        '';
      };
  };
}
