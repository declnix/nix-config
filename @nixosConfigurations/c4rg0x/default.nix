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
          comma
        ];

        programs.nix-index.enable = true;
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
      home-manager.users.nixos = import ./home.nix;
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
