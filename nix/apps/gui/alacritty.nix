# @nix-config-modules
{ ... }:
{
  nix-config.apps.alacritty = {
    home = {
      programs.alacritty = {
        enable = true;
      };
    };
  };
}
