{ ... }: {
  den.aspects.gaia = {
    to-users = {
      hjem = { pkgs, ... }: {
        packages = with pkgs; [ glab ];
      };
    };
  };

  impure-files.hosts.gaia."/etc/xdg/glab-cli/config.yml" = {
    text = ''
      host: ''${GITLAB_HOST}
    '';
  };
}
