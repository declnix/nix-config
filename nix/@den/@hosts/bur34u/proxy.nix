{ den, ... }:
{
  den.aspects.bur34u = {
    nixos =
      { pkgs, ... }:
      {
        systemd.services.nix-daemon.serviceConfig = {
          EnvironmentFile = "-/etc/proxy";
        };

        security.sudo.extraConfig = ''
          Defaults env_keep += "http_proxy https_proxy no_proxy HTTP_PROXY HTTPS_PROXY NO_PROXY"
        '';
      };

    provides.to-users = {
      zsh = {
        extraConfig = ''
          [ -f /etc/proxy ] && source /etc/proxy
        '';
      };
    };
  };
}
