{ inputs, ... }:
let
  inherit (inputs) flake-parts;
  perSystem =
    {
      config,
      self',
      pkgs,
      system,
      ...
    }:
    {
      devShells.default = pkgs.mkShell {
        name = "nix-config";
        buildInputs =
          with pkgs;
          [
            zsh
            just
            gnumake
          ]
          ++ config.pre-commit.settings.enabledPackages;

        shellHook = ''
          ${config.pre-commit.installationScript}
        '';
      };

      pre-commit.settings.hooks.nixfmt-rfc-style.enable = true;

      formatter = pkgs.nixfmt-rfc-style;
    };

  flake = {
    imports = [
      inputs.nix-config-modules.flakeModule
      inputs.git-hooks.flakeModule
    ]
    ++ [
      (
        { lib, config, ... }:

        let
          apps = config.nix-config.apps;

          allTags = builtins.concatMap (app: app.tags or [ ]) (builtins.attrValues apps);
        in
        {
          nix-config.defaultTags = builtins.listToAttrs (
            map (t: {
              name = t;
              value = lib.mkDefault false;
            }) allTags
          );
        }
      )
    ]
    ++ [
      ./modules.nix
    ];

    nix-config.homeApps = [ ];

    inherit perSystem;

    systems = [ "x86_64-linux" ];
  };

in
flake-parts.lib.mkFlake { inherit inputs; } flake // flake
