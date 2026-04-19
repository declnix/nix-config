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

          programs.regreet = {
            enable = true;
            font = {
              package = pkgs.nerd-fonts.jetbrains-mono;
              name = "JetBrainsMono Nerd Font";
              size = 14;
            };
            extraCss = ''
              window {
                background-color: #1e1e2e;
              }
              box#main_box {
                background-color: #313244;
                border-radius: 12px;
                padding: 32px;
              }
              label {
                color: #cdd6f4;
              }
              entry {
                background-color: #45475a;
                color: #cdd6f4;
                border: 1px solid #585b70;
                border-radius: 6px;
              }
              button {
                background-color: #89b4fa;
                color: #1e1e2e;
                border-radius: 6px;
                border: none;
              }
              button:hover {
                background-color: #b4befe;
              }
            '';
          };

          programs.niri.enable = true;
          security.pam.services.swaylock = { };

          environment.systemPackages = [ pkgs.swaylock pkgs.swayidle ];

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

  den.hosts.x86_64-linux.z4c1sz3 = { };
}
