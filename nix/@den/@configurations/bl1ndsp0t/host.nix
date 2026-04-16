{ den, ... }:
{
  den.aspects.bl1ndsp0t =
    { host, ... }:
    {
      nixos =
        { pkgs, ... }:
        {
          boot.loader.systemd-boot.enable = true;
          boot.loader.efi.canTouchEfiVariables = true;

          networking.networkmanager.enable = true;

          services = {
            desktopManager.plasma6.enable = true;
            displayManager.sddm = {
              enable = true;
              wayland.enable = true;
            };
          };

          programs.niri.enable = true;

          virtualisation = {
            libvirtd.enable = true;
          };

          programs.virt-manager.enable = true;

        };

      includes = with den.aspects; [
        podman
        sudo
        fonts
      ];
    };

  den.hosts.x86_64-linux.bl1ndsp0t = { };
}
