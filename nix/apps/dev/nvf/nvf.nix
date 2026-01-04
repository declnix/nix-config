# @nix-config-modules
{ inputs, ... }:
{
  nix-config.apps.nvf = {
    home =
      { pkgs, ... }:
      {
        programs.nvf = {
          settings = {
            vim = {
              viAlias = true;
              vimAlias = true;

              lsp = {
                enable = true;
              };
            };
          };
          enable = true;
        };

        home.sessionVariables = {
          EDITOR = "nvim";
        };

        imports = [
          ./modules.nix
        ];
      };

    nixos = {
      environment.variables.EDITOR = "nvim";
    };

    tags = [
      "dev"
    ];

    nixpkgs = {
      params.overlays = [
        (import ./overlay.nix { inherit inputs; })
      ];
    };
  };

  nix-config.modules.home-manager = [
    inputs.nvf.homeManagerModules.default
  ];
}
