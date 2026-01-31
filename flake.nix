{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flakelight.url = "github:nix-community/flakelight";
    wrappers.url = "github:lassulus/wrappers";
    nzf.url = "github:yehvaed/nzf";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
  };

  outputs = inputs@{ flakelight, ... }: (flakelight ./.) (import ./outputs.nix inputs);
}
