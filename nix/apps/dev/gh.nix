# @nix-config-modules
{ ... }:
{
  nix-config.apps.gh = {
    home = {
      programs.gh = {
        enable = true;
      };
    };
    tags = [
      "dev"
    ];
  };
}
