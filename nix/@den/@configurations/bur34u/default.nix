{ den, ... }:
{
  den.aspects.nixos.provides.bur34u =
    { ... }:
    {
      nixos = {
        users.users.nixos.initialPassword = "test";
      };

      includes = [
        den._.primary-user
        (den._.user-shell "zsh")
      ]
      ++ (with den.aspects; [ dev-tools ]);
    };

  den.hosts.x86_64-linux.bur34u.users.nixos = { };

  den.aspects.bur34u =
    { host, ... }:
    {
      includes = with den.aspects; [
        wsl
        fonts
        podman
      ];
    };

  den.hosts.x86_64-linux.bur34u = { };
}
