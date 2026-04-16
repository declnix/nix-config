{ den, inputs, ... }:
{
  den.aspects.wsl = {
    nixos =
      { ... }:
      {
        imports = [ inputs.nixos-wsl.nixosModules.wsl ];
        wsl = {
          enable = true;
          interop.register = true;
        };
        programs.nix-ld.enable = true;
      };
  };

  flake-file.inputs = {
    nixos-wsl = {
      url = "github:nix-community/nixos-wsl";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-compat.follows = "";
    };
  };
}
