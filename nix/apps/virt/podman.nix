# @nix-config-modules
{
  nix-config.apps.podman = {
    nixos =
      { pkgs, ... }:
      {

        virtualisation = {
          containers.enable = true;

          podman = {
            enable = true;
            dockerCompat = true;
            defaultNetwork.settings.dns_enabled = true;
          };

          oci-containers.backend = "podman";
        };

        environment.systemPackages = with pkgs; [ docker-compose ];

        environment.variables = {
          PODMAN_IGNORE_CGROUPSV1_WARNING = "1";
        };
      };

    tags = [
      "containers"
    ];
  };
}
