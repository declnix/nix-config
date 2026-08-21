{ inputs, ... }:
{
  den.aspects.terra = {
    provides.declnix = {
      hjem = { pkgs, ... }: {
        packages = [ pkgs.pi-coding-agent ];
      };

      nixos = { ... }: {
        nix.settings.extra-substituters = [
          "https://pi.cachix.org"
        ];

        nix.settings.extra-trusted-public-keys = [
          "pi.cachix.org-1:lGeoGJaZ5ZDabuRzkcD5EBTNnDM4HJ1vqeOxlWk1Flk="
        ];

        nixpkgs.overlays = [ inputs.pi.overlays.default ];
      };
    };
  };
}
