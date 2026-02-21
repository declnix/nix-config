{ inputs, ... }:
{
  system = "x86_64-linux";

  modules = [
    {
      networking.hostName = "bl1ndsp0t";
      i18n.defaultLocale = "en_US.UTF-8";
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
            "libvirtd"
            "kvm"
          ];

          initialPassword = "password";
          ignoreShellProgramCheck = true;
        };
      }
    )

    (
      { inputs, pkgs, ... }:
      {
        users.users.declnix = {
          packages =
            (with inputs.self.packages.${pkgs.system}; [
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
              eza
              bat

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
        fonts.packages = with pkgs; [ nerd-fonts.fira-code ];
      }
    )

    (
      { pkgs, ... }:
      {
        environment.systemPackages = with pkgs; [ vim ];
      }
    )

    {
      virtualisation.libvirtd.enable = true;
      programs.virt-manager.enable = true;
    }

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
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.users.declnix = import ./home.nix;
    }

    {
      nix.settings.experimental-features = [
        "nix-command"
        "flakes"
        "pipe-operators"
      ];

      nixpkgs.config.allowUnfree = true;
    }

    ./configuration.nix
    inputs.home-manager.nixosModules.home-manager
  ];
}
