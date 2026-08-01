{ inputs, ... }:
{
  den.aspects.kr7va = {
    provides.declnix = {
      hjem = {
        programs.noctalia = {
          enable = true;
          settings = builtins.fromTOML (builtins.readFile ./config.toml);
        };
      };

      nixos =
        { pkgs, ... }:
        let
          greeterSettings = {
            output.scale = 1.0;
          };
          greeterConfigFile = (pkgs.formats.toml { }).generate "greeter.toml" greeterSettings;
        in
        {
          imports = [
            inputs.noctalia-greeter.nixosModules.default
          ];

          nix.settings = {
            extra-substituters = [ "https://noctalia.cachix.org" ];
            extra-trusted-public-keys = [
              "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
            ];
          };

          hjem.extraModules = [
            inputs.noctalia.hjemModules.default
          ];

          programs.noctalia-greeter = {
            enable = true;
            greeter-args = "--session niri --user declnix";
            package = inputs.noctalia-greeter.packages.${pkgs.stdenv.hostPlatform.system}.default;
            settings = greeterSettings;
          };

          system.activationScripts.noctaliaGreeterConfig.text = ''
            ${pkgs.coreutils}/bin/install -d -o greeter -g greeter -m 0750 /var/lib/noctalia-greeter
            ${pkgs.coreutils}/bin/install -o greeter -g greeter -m 0644 ${greeterConfigFile} /var/lib/noctalia-greeter/greeter.toml
          '';
        };
    };
  };

  flake-file.nixConfig = {
    extra-substituters = [ "https://noctalia.cachix.org" ];
    extra-trusted-public-keys = [
      "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
    ];
  };

  flake-file.inputs = {
    noctalia.url = "github:noctalia-dev/noctalia/cachix";
    noctalia-greeter = {
      url = "github:noctalia-dev/noctalia-greeter";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
