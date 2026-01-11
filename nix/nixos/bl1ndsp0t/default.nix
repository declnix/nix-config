{
  system = "x86_64-linux";

  modules = [
    {
      # Boot
      boot.loader.systemd-boot.enable = true;
      boot.loader.efi.canTouchEfiVariables = true;

      # Network
      networking.hostName = "bl1ndsp0t";
      networking.networkmanager.enable = true;

      # Time & Locale
      time.timeZone = "Europe/Warsaw";
      i18n.defaultLocale = "en_US.UTF-8";

      # Hardware - Lenovo ThinkBook
      # hardware.lenovoThinkBook16G4IAP.enable = true;

      system.stateVersion = "24.05";
    }

    (
      { pkgs, ... }:
      {
        users.users.declnix = {
          isNormalUser = true;
          home = "/home/declnix";
          extraGroups = [
            "wheel"
            "networkmanager"
          ];
          shell = pkgs.zsh;

          initialPassword = "password";
          ignoreShellProgramCheck = true;
        };
      }
    )

    (
      { pkgs, ... }:
      {
        users.users.declnix = {
          packages = (
            with pkgs;
            [
              git
              wget
              curl
              zsh
            ]
          );
        };
      }
    )

    (
      { pkgs, ... }:
      {
        environment.systemPackages = with pkgs; [
          vim
        ];
      }
    )

    {
      virtualisation.vmVariant = {
        users.users.declnix.password = "password";
        security.sudo.wheelNeedsPassword = false;
      };
    }

    ./hardware-configuration.nix
  ];
}
