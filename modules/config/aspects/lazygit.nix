{ den, ... }:
{
  den.aspects.lazygit = {
    nvim = { ... }: {
      terminal.toggleterm = {
        enable = true;
        lazygit.enable = true;
      };
    };

    hjem = { pkgs, ... }: {
      packages = with pkgs; [ lazygit ];
    };

    includes = [ den.aspects.git ];
  };
}
