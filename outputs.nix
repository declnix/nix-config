{ flakelight, ... }@inputs:
flakelight ./. {
  inherit inputs;

  nixDirAliases = {
    nixosConfigurations = [ "@nixosConfigurations" ];
    packages = [ "@packages" ];
  };

  nixDir = ./.;

  nixpkgs.config.allowUnfree = true;
}
