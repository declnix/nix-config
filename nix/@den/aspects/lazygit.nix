{ den, ... }:
{
  den.aspects.lazygit = {
    hjem = { pkgs, ... }: {
      packages = [ pkgs.lazygit ];
      rum.programs.zsh.initConfig = ''
        alias lg='lazygit'
      '';
    };
  };
}
