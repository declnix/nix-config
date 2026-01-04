# @nix-config-modules
{ ... }:
{
  nix-config.apps.zoxide = {
    enable = true;
    home = {
      programs.zoxide = {
        enable = true;
        enableZshIntegration = true;
      };
    };
  };
}
