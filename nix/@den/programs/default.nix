{ ... }:
{
  den.aspects.sudo = {
    nixos = {
      security.sudo.enable = true;
      security.sudo.wheelNeedsPassword = false;
    };
  };

  den.aspects.git = {
    hjem =
      { ... }:
      {
        rum.programs.git.enable = true;
      };
  };

  den.aspects.fonts = {
    nixos =
      { pkgs, ... }:
      {
        fonts.packages = with pkgs.nerd-fonts; [
          fira-code
          jetbrains-mono
        ];
      };
  };

  den.aspects.zscaler = {
    nixos =
      { pkgs, ... }:
      {
        security.pki.certificateFiles = [
          "${pkgs.zscaler-cacert}/etc/ssl/certs/zscaler-ca.crt"
        ];
      };
  };
}
