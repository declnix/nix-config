# @nix-config-modules
{
  nix-config.apps.fd = {
    enable = true;

    home = {
      programs.fd = {
        enable = true;
      };
    };
  };
}
