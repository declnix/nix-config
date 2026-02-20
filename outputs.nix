inputs: {
  inherit inputs;

  nixDirAliases = {
    nixosConfigurations = [ "@nixosConfigurations" ];
    packages = [ "@packages" ];
  };

  nixDir = ./.;

  nixpkgs.config.allowUnfree = true;

  devShells.default = pkgs: pkgs.mkShell { packages = [ pkgs.nixfmt-rfc-style pkgs.just ]; };
}
