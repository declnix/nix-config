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

  den.aspects.declnix.provides.bur34u =
    { ... }:
    {
      nixos = {
        users.users.declnix.initialPassword = "test";
      };

      includes = [
        den._.primary-user
        (den._.user-shell "zsh")
      ]
      ++ (with den.aspects; [ dev-tools ]);
    };

  den.hosts.x86_64-linux.bur34u.users.declnix = { };

  den.aspects.bur34u =
    { host, ... }:
    {
      includes = with den.aspects; [ wsl ];
    };

  den.hosts.x86_64-linux.bur34u = { };
}
