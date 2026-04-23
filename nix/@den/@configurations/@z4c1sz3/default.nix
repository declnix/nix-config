{ den, ... }:
{
  den.aspects.z4c1sz3 =
    { host, ... }:
    {
      nixos =
        { pkgs, ... }:
        {
          boot.loader.systemd-boot.enable = true;
          boot.loader.efi.canTouchEfiVariables = true;

          networking.networkmanager.enable = true;

          programs.niri.enable = true;
          security.pam.services.swaylock = { };

          environment.systemPackages = [
            pkgs.swaylock
            pkgs.swayidle
          ];

          virtualisation = {
            libvirtd.enable = true;
          };

          programs.virt-manager.enable = true;

          time.timeZone = "Europe/Warsaw";

          fonts.fontconfig.defaultFonts = {
            monospace = [ "JetBrainsMono Nerd Font" ];
            sansSerif = [ "JetBrainsMono Nerd Font" ];
            serif = [ "JetBrainsMono Nerd Font" ];
          };
        };

      includes = with den.aspects; [
        podman
        sudo
        fonts
      ];
    };

  den.hosts.x86_64-linux.z4c1sz3 = { };
}
