{ inputs, ... }: 
{
  system = "x86_64-linux";

  modules = [
    {
      networking.hostName = "c4rg0x";
      i18n.defaultLocale = "en_US.UTF-8";
    }

    (
      { pkgs, ... }:
      {
        home-manager.users.nixos = { pkgs, ... }: {
          programs.git = {
            enable = true;
            extraConfig = {
              credential.helper = "/mnt/c/Program\\ Files/Git/mingw64/bin/git-credential-manager.exe";
            };
          };

          programs.zsh = {
            enable = true;
            enableCompletion = true;
          };

          programs.direnv = {
            enable = true;
            nix-direnv.enable = true;
          };

          programs.fzf.enable = true;
          programs.ripgrep.enable = true;
          programs.bat.enable = true;
          programs.eza = {
            enable = true;
            enableZshIntegration = true;
          };

          home.packages = with pkgs; [ devbox openshift ];

          home.stateVersion = "25.11";
        };

        users.users.nixos = {
          isNormalUser = true;
          home = "/home/nixos";
          
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
        fonts.packages = with pkgs; [ nerd-fonts.fira-code ];
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
      programs.git = {
        enable = true;

        config = {
          credential.helper = "/mnt/c/Program\\ Files/Git/mingw64/bin/git-credential-manager.exe";
        };
      };
    }

    {
      security.sudo.enable = true;
      security.sudo.wheelNeedsPassword = false;
    }

    {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
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
