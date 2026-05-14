{
  inputs,
  den,
  lib,
  bur34u,
  ...
}:
{
  imports = [ (inputs.den.namespace "bur34u" false) ];

  den.aspects.bur34u = {
    includes =
      (with den.aspects; [
        podman
        fonts
      ])
      ++ (builtins.attrValues bur34u);
  };

  bur34u.proxy = {
    nixos = {
      systemd.services.nix-daemon.serviceConfig.EnvironmentFile = "-/etc/proxy";

      security.sudo.extraConfig = ''
        Defaults env_keep += "http_proxy https_proxy no_proxy HTTP_PROXY HTTPS_PROXY NO_PROXY"
      '';
    };

    provides.to-users = {
      zsh = {
        initConfig = ''
          if [ -f /etc/proxy ]; then
            set -a; source /etc/proxy; set +a
          fi
        '';
      };
    };
  };

  den.hosts.x86_64-linux.bur34u = {
    wsl.enable = true;
  };
}
