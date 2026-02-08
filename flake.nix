{
  inputs = {
    # ===========================================================
    # CHANNELS
    # ===========================================================
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    # ===========================================================
    # PLATFORMS
    # ===========================================================   
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";

    # ===========================================================
    # FRAMEWORKS
    # ===========================================================   
    flakelight = {
      url = "github:nix-community/flakelight";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    wrappers.url = "github:lassulus/wrappers";

    # ===========================================================
    # APPLICATIONS
    # ===========================================================
    nzf.url = "github:yehvaed/nzf";
  };

  outputs = inputs@{ flakelight, ... }: (flakelight ./.) (import ./outputs.nix inputs);
}
