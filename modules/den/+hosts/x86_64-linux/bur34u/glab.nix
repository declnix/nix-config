{ ... }: {
  den.aspects.bur34u = {
    to-users = {
      hjem = { pkgs, ... }: {
        packages = with pkgs; [ glab ];
      };
    };
  };

  impure-files.hosts.bur34u."/etc/xdg/glab-cli/config.yml" = {
    text = ''
      host: ''${GITLAB_HOST}
    '';
  };
}
