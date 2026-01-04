# @nix-config-modules
{ inputs, ... }:
{
  nix-config.apps.wsl = {
    nixos =
      { host, ... }:
      {
        wsl = {
          enable = true;
          defaultUser = "${host.username}";
          interop.register = true;
        };
      };

    tags = [ "wsl" ];
  };

  nix-config.modules.nixos = [
    inputs.nixos-wsl.nixosModules.wsl
  ];
}
