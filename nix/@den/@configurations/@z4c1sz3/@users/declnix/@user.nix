{ den, ... }:
{
  den.aspects.declnix = {
    hjem =
      { pkgs, ... }:
      {
        packages = with pkgs; [
          codex
          wget
          curl
          firefox
        ];
      };

    includes = [
      den._.primary-user
      (den._.user-shell "zsh")
    ]
    ++ (with den.aspects; [
      dev-tools
      dev-ai
    ]);

    provides.z4c1sz3.nixos = {
      users.users.declnix.initialPassword = "test";
    };
  };

  den.hosts.x86_64-linux.z4c1sz3.users.declnix = { };
}
