# @nix-config-modules
{
  nix-config.apps.eza = {
    enable = true;

    home = {
      programs.eza = {
        extraOptions = [ "--group-directories-first" ];

        colors = "always";
        icons = "always";
        git = true;

        enable = true;
      };
    };
  };
}
