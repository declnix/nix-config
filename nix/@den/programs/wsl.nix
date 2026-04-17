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

    hjem =
      { ... }:
      {
        rum.programs.git.settings.credential.helper =
          "/mnt/c/Program\\ Files/Git/mingw64/bin/git-credential-manager.exe";
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
