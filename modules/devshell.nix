{ ... }:
{
  perSystem = { config, pkgs, ... }: {
    devShells.default = pkgs.mkShell {
      packages = [
        pkgs.gettext
        pkgs.gnumake
        pkgs.just
      ];

      shellHook = ''
        ${config.pre-commit.shellHook}
      '';
    };
  };
}
