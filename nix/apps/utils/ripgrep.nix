# @nix-config-modules
{
  nix-config.apps.ripgrep = {
    enable = true;

    home = {
      programs.ripgrep = {
        enable = true;
      };
    };
  };
}
