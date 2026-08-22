{ ... }:
let
  host = "gaia";
in
{
  den.aspects.${host} = {
    to-users = {
      hjem = { pkgs, ... }: {
        packages = with pkgs; [ glab ];
      };
    };
  };

  host-files.${host} = {
    "/etc/xdg/glab-cli/config.yml" = {
      text = ''
        host: ''${GITLAB_HOST}
      '';
    };
  };
}
