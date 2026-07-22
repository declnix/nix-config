{ den, ... }:
{
  den.aspects.lazygit = {
    hjem = { pkgs, ... }: {
      packages = with pkgs; [ lazygit ];
    };

    includes = [ den.aspects.git ];
  };
}
