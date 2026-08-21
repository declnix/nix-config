{ den
, ...
}:
{
  den.aspects.gaia = {
    nixos = {
      # Reserve ports for local development services.
      boot.kernel.sysctl."net.ipv4.ip_local_reserved_ports" = "61000-64999";
    };

    includes = with den.aspects; [ podman fonts ];
  };

  den.hosts.x86_64-linux.gaia = {
    wsl.enable = true;
    users.nixos-user.userName = "nixos";
  };
}
