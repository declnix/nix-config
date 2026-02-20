inputs: {
  inherit inputs;

  nixDirAliases = {
    nixosConfigurations = [ "@nixosConfigurations" ];
  };

  nixDir = ./.;

  nixpkgs.config.allowUnfree = true;

  devShells.default = pkgs: pkgs.mkShell { packages = [ pkgs.nixfmt-rfc-style pkgs.just ]; };
}
