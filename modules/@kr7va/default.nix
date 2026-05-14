{
  inputs,
  den,
  kr7va,
  ...
}:
{
  imports = [ (inputs.den.namespace "kr7va" false) ];

  den.aspects.kr7va = {
    nixos =
      { pkgs, ... }:
      {
        time.timeZone = "Europe/Warsaw";
      };

    includes =
      (with den.aspects; [
        libvirt
        podman
        ssh
        sudo
        fonts
      ])
      ++ (builtins.attrValues kr7va)
      ++ [ (den.batteries.import-tree ./hardware) ];
  };

  kr7va.tailscale = {
    nixos = {
      services.tailscale.enable = true;
      networking.firewall.trustedInterfaces = [ "tailscale0" ];
    };
  };

  kr7va.network = {
    nixos = {
      networking.networkmanager.enable = true;
    };
  };

  kr7va.greetd = {
    nixos =
      { pkgs, ... }:
      {
        services.greetd = {
          enable = true;
          settings.default_session.command = "${pkgs.greetd.tuigreet}/bin/tuigreet --cmd niri-session";
        };
      };
  };

  den.hosts.x86_64-linux.kr7va = { };
}
