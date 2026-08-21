{ den
, ...
}:
{
  den.aspects.bur34u = {
    nixos = {
      # Reserve ports for local development services.
      boot.kernel.sysctl."net.ipv4.ip_local_reserved_ports" = "61000-64999";
    };

    includes = with den.aspects; [ podman fonts ];
  };

  den.hosts.x86_64-linux.bur34u = {
    wsl.enable = true;
    users.nixos-user.userName = "nixos";
  };
}
