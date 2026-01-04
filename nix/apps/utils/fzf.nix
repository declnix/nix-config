# @nix-config-modules
{
  nix-config.apps.fzf = {
    enable = true;

    home = {
      programs.fzf = {
        enable = true;
      };
    };
  };
}
