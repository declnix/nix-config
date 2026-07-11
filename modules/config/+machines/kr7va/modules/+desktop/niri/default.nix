{ inputs, ... }:
{
  den.aspects.kr7va = {
    provides.declnix = {
      hjem = { ... }: {
        files.".config/niri/config.kdl".text = builtins.readFile ./full-config.kdl;
      };

      nixos = {
        imports = [
          inputs.niri-flake.nixosModules.niri
        ];

        nix.settings = {
          extra-substituters = [ "https://niri.cachix.org" ];
          extra-trusted-public-keys = [
            "niri.cachix.org-1:Wv0OmO7PsuocRKzfDoJ3mulSl7Z6oezYhGhR+3W2964="
          ];
        };

        programs.niri.enable = true;
      };
    };
  };

  flake-file.nixConfig = {
    extra-substituters = [ "https://niri.cachix.org" ];
    extra-trusted-public-keys = [
      "niri.cachix.org-1:Wv0OmO7PsuocRKzfDoJ3mulSl7Z6oezYhGhR+3W2964="
    ];
  };

  flake-file.inputs.niri-flake.url = "github:sodiboo/niri-flake";
}
