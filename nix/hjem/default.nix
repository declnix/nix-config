{ inputs, lib, ... }: {
  imports = [
    ./bat.nix
    ./eza.nix
    ./lazygit.nix
    ./waybar.nix
    ./zsh.nix
  ] ++ [
    inputs.hjem-rum.hjemModules.default
  ];
}
