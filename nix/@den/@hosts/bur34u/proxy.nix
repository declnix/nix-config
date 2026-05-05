{ den, ... }:
let
  sourceExported = file: "set -a; source ${file}; set +a";
in
{
  den.aspects.bur34u = {
    nixos =
      { pkgs, ... }:
      {
        systemd.services.nix-daemon.serviceConfig = {
          ExecStartPre = pkgs.writeShellScript "gen-proxy-env" ''
            [ -f /etc/proxy.env ] || exit 0
            ${sourceExported "/etc/proxy.env"}
            env | grep -iE '^(http|https|no)_proxy=' > /run/nix-proxy.env || true
          '';
          EnvironmentFile = "-/run/nix-proxy.env";
        };

        security.sudo.extraConfig = ''
          Defaults env_keep += "http_proxy https_proxy no_proxy HTTP_PROXY HTTPS_PROXY NO_PROXY"
        '';
      };

    provides.to-users = {
      zsh = {
        initConfig = ''
          if [ -f /run/nix-proxy.env ]; then
            ${sourceExported "/run/nix-proxy.env"}
          fi
        '';
      };
    };
  };
}
