{ config, den, lib, ... }:
let
  host = "gaia";

  caBundle = "/etc/ssl/certs/ca-certificates.crt";
  hostFiles = config.host-files.${host};

  proxyVars = [
    "http_proxy"
    "https_proxy"
    "all_proxy"
    "no_proxy"
    "HTTP_PROXY"
    "HTTPS_PROXY"
    "ALL_PROXY"
    "NO_PROXY"
  ];

  caVars = [
    "NIX_SSL_CERT_FILE"
    "SSL_CERT_FILE"
    "CURL_CA_BUNDLE"
    "GIT_SSL_CAINFO"
  ];

  caEnv = map (name: "${name}=${caBundle}") caVars;
  caSessionVars = lib.genAttrs caVars (_: caBundle);
  proxyEnvFile = hostFiles."/etc/environment.d/90-proxy.conf".target;
in
{
  den.aspects.${host} = {
    to-users = {
      hjem = {
        rum.programs.git.settings = {
          include.path = hostFiles."/etc/gitconfig.d/proxy.conf".target;
          http.sslCAInfo = caBundle;
        };

        environment.sessionVariables = caSessionVars;
      };

      zsh = {
        initConfig = ''
          proxy_env=${proxyEnvFile}
          if [ -r "$proxy_env" ]; then
            while IFS='=' read -r key value; do
              case "$key" in
                http_proxy|https_proxy|all_proxy|no_proxy|HTTP_PROXY|HTTPS_PROXY|ALL_PROXY|NO_PROXY)
                  export "$key=$value"
                  ;;
              esac
            done < "$proxy_env"
          fi
        '';
      };
    };

    nixos = {
      nix.settings.ssl-cert-file = caBundle;

      systemd = {
        services = {
          nix-daemon.serviceConfig = {
            EnvironmentFile = "-${proxyEnvFile}";
            Environment = lib.mkAfter caEnv;
          };
        };

        user.services = {
          podman.serviceConfig = {
            EnvironmentFile = "-${proxyEnvFile}";
            Environment = lib.mkAfter caEnv;
          };
        };
      };

      security.sudo.extraConfig = ''
        Defaults env_keep += "${lib.concatStringsSep " " (proxyVars ++ caVars)}"
      '';
    };

    includes = with den.aspects; [ zscaler ];
  };

  host-files.${host} = {
    "/etc/environment.d/90-proxy.conf" = {
      text = ''
        http_proxy=''${http_proxy}
        https_proxy=''${https_proxy}
        all_proxy=''${all_proxy}
        no_proxy=''${no_proxy}
        HTTP_PROXY=''${HTTP_PROXY}
        HTTPS_PROXY=''${HTTPS_PROXY}
        ALL_PROXY=''${ALL_PROXY}
        NO_PROXY=''${NO_PROXY}
      '';
    };

    "/etc/gitconfig.d/proxy.conf" = {
      text = ''
        [http]
          proxy = ''${http_proxy}

        [http "https://"]
          proxy = ''${https_proxy}
      '';
    };
  };
}
