{ inputs, ... }:
{
  system = "x86_64-linux";

  modules = [
    {
      networking.hostName = "pstnd01";
      i18n.defaultLocale = "en_US.UTF-8";
    }

    (
      { pkgs, ... }:
      {
        home-manager.users.nixos =
          { pkgs, ... }:
          {
            programs.git = {
              enable = true;
              extraConfig = {
                credential.helper = "/mnt/c/Program\\ Files/Git/mingw64/bin/git-credential-manager.exe";
              };
            };

            programs.zsh = {
              enable = true;
              enableCompletion = true;

              autosuggestion.enable = true;
              syntaxHighlighting.enable = true;

              oh-my-zsh = {
                enable = true;
                plugins = [ "git" ];
                theme = "robbyrussell";
              };
              plugins = [
                {
                  name = "zsh-fzf-history-search";
                  src = pkgs.zsh-fzf-history-search;
                }
                {
                  name = "fzf-tab";
                  src = pkgs.fetchFromGitHub {
                    owner = "Aloxaf";
                    repo = "fzf-tab";
                    rev = "v1.2.0";
                    sha256 = "sha256-q26XVS/LcyZPRqDNwKKA9exgBByE0muyuNb0Bbar2lY=";
                  };
                }
              ];
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

            home.packages = with pkgs; [
              devbox
              openshift
            ];

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
          subUidRanges = [
            {
              startUid = 100000;
              count = 65536;
            }
          ];
          subGidRanges = [
            {
              startGid = 100000;
              count = 65536;
            }
          ];
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

    # FIXME: this is very hacky workaround, find how to make it works properly with corporate proxy
    (
      { pkgs, ... }:
      {
        systemd.services.proxy-forward = {
          wantedBy = [ "multi-user.target" ];
          after = [ "network-online.target" ];
          serviceConfig.Restart = "always";
          script = ''
            HOST=$(${pkgs.iproute2}/bin/ip route | ${pkgs.gawk}/bin/awk '/default/ {print $3}')
            exec ${pkgs.socat}/bin/socat TCP-LISTEN:9000,fork,reuseaddr TCP:$HOST:9000
          '';
        };

        networking.proxy.default = "http://127.0.0.1:9000";
        networking.proxy.noProxy = "127.0.0.1,localhost,intra.laposte.fr,gitlab.net.extra.laposte.fr";
      }
    )

    (
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

        environment.systemPackages = with pkgs; [
          docker-compose
          fuse-overlayfs
        ];

        environment.variables = {
          PODMAN_IGNORE_CGROUPSV1_WARNING = "1";
        };
      }
    )

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
