# @nix-config-modules
{
  nix-config.apps.opencode = {
    home =
      { pkgs, ... }:
      {
        home.packages = [ pkgs.opencode ];
      };

    tags = [ "ai" ];
  };
}
