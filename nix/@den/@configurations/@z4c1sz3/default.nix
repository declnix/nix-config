{ den, ... }:
{
  den.aspects.z4c1sz3 = {
    nixos =
      { pkgs, ... }:
      {
        boot.loader.systemd-boot.enable = true;
        boot.loader.efi.canTouchEfiVariables = true;

        networking.networkmanager.enable = true;
        networking.firewall.allowedTCPPorts = [ 5173 ];
        
        services.tailscale.enable = true;
        networking.firewall.trustedInterfaces = [ "tailscale0" ];

        services.openssh = {
          enable = true;
          ports = [ 2222 ];
          settings = {
            AllowUsers = [ "declnix" ];
            PasswordAuthentication = true;
            KbdInteractiveAuthentication = true;
            PermitRootLogin = "no";
            X11Forwarding = false;
          };
        };
        networking.firewall.allowedTCPPorts = [ 2222 ];

        programs.niri.enable = true;

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
