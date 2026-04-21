{ den, ... }:
{
  den.aspects.bur34u.nixos =
    { pkgs, ... }:
    {
      systemd.services.nix-proxy-env = {
        wantedBy = [ "nix-daemon.service" ];
        before = [ "nix-daemon.service" ];
        path = [
          pkgs.iproute2
          pkgs.gawk
        ];
        serviceConfig = {
          Type = "oneshot";
          RemainAfterExit = true;
          ExecStart = pkgs.writeShellScript "eval-proxy-env" ''
            [ -f /etc/proxy.env ] || exit 0
            set -a; source /etc/proxy.env; set +a
            env | grep -iE '^(http|https|no)_proxy=' > /run/nix-proxy.env
          '';
        };
      };

      systemd.services.nix-daemon.serviceConfig.EnvironmentFile = "-/run/nix-proxy.env";

      security.sudo.extraConfig = ''
        Defaults env_keep += "http_proxy https_proxy no_proxy HTTP_PROXY HTTPS_PROXY NO_PROXY"
      '';

      programs.zsh.shellInit = ''
        if [ -f /run/nix-proxy.env ]; then
          set -a
          source /run/nix-proxy.env
          set +a
        fi
      '';
    };
}
