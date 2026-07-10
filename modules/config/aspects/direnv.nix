{
  den.aspects.direnv = {
    hjem =
      { ... }:
      {
        rum.programs.direnv = {
          enable = true;
          integrations.zsh.enable = true;
        };
      };

    # Reserve ports for local development services.
    nixos = {
      boot.kernel.sysctl."net.ipv4.ip_local_reserved_ports" = "61000-64999";
    };
  };
}
