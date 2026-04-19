{ den, ... }:
{
  den.aspects.utils = {
    hjem = { ... }: {
      rum.programs.yazi = {
        enable = true;
        integrations.zsh.enable = true;
      };
      rum.programs.lazygit = {
        enable = true;
        integrations.zsh.enable = true;
      };
    };
  };
}
