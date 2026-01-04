# @nix-config-modules
{
  nix-config.apps.claude-code = {
    home =
      { pkgs, ... }:
      {
        home.packages = [ pkgs.claude-code ];
      };

    nixpkgs = {
      packages.unfree = [ "claude-code" ];
    };

    tags = [ "ai" ];
  };
}
