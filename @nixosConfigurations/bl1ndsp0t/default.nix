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
      { config, pkgs, ... }:
      {
        users.users.declnix = {
          packages =
            (with outputs.packages.${pkgs.system}; [
              (zsh.apply {
                aliases = {
                  rebuild = "sudo nixos-rebuild switch --flake .";
                  gs = "git status";
                };
              })

              tmux
            ])
            ++ (with pkgs; [
              git
              wget
              curl
              fzf

              # ai
              claude-code

              # gui / browsers
              firefox
            ]);
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
      services = {
        desktopManager.plasma6.enable = true;
        displayManager.sddm.enable = true;
        displayManager.sddm.wayland.enable = true;
      };
    }

    {
      security.sudo.enable = true;
      security.sudo.wheelNeedsPassword = false;
    }

    {
      virtualisation.vmVariant = {
        users.users.declnix.password = "password";
        security.sudo.wheelNeedsPassword = false;
      };
    }

    {
      nix.settings.experimental-features = [
        "nix-command"
        "flakes"
      ];
    }

    ./hardware-configuration.nix
  ];
}
