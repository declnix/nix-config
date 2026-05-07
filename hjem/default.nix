{ inputs, lib, ... }:
{
  imports = [
    ./bat.nix
    ./eza.nix
    ./lazygit.nix
    ./waybar.nix
    inputs.hjem-rum.hjemModules.default
  ];
}
