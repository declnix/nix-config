{ den, ... }:
{
  den.aspects.kr7va = {
    provides.declnix = {
      nixos = { pkgs, ... }: {
        services.ollama = {
          enable = true;
          package = pkgs.ollama-cpu;

          host = "127.0.0.1";
          port = 11434;

          environmentVariables = {
            OLLAMA_NUM_PARALLEL = "1";
            OLLAMA_MAX_QUEUE = "256";
          };
        };

        services.open-webui = {
          enable = true;

          host = "0.0.0.0";
          port = 8080;

          environment = {
            OLLAMA_API_BASE_URL = "http://127.0.0.1:11434";

            ENABLE_API_KEYS = "True";

            ANONYMIZED_TELEMETRY = "False";
            DO_NOT_TRACK = "True";
            SCARF_NO_ANALYTICS = "True";
          };
        };

        services.n8n = {
          enable = true;
          openFirewall = false;

          environment = {
            N8N_PORT = "5678";
            N8N_DIAGNOSTICS_ENABLED = "false";
            N8N_VERSION_NOTIFICATIONS_ENABLED = "false";
          };
        };

        networking.firewall.allowedTCPPorts = [ 80 ];
      };

      includes = [
        (den.batteries.unfree [
          "n8n"
          "open-webui"
        ])
      ];
    };
  };
}
