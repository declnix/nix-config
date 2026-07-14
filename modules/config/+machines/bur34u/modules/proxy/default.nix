{ den, lib, ... }:
let
  # Keep proxy/no_proxy values out of the flake. systemd reads this host-local
  # env file at runtime, so evaluation stays pure and no proxy domains enter Git.
  proxyEnvFile = "/etc/environment.d/90-proxy.conf";
  caBundle = "/etc/ssl/certs/ca-certificates.crt";

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
in
{
  den.aspects.bur34u = {
    provides.to-users = {
      hjem = {
        rum.programs.git.settings.http.sslCAInfo = caBundle;

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

    nixos =
      { ... }:
      {
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
}
