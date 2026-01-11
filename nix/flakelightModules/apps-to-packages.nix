# flakelightModules/apps-to-packages.nix
{ lib, config, ... }:
{
  perSystem = { config, ... }: {
    packages = config.packages // (lib.mapAttrs
      (name: app:
        # Parse "${wrapped}/bin/zsh" -> /nix/store/xxx-zsh
        let
          programPath = app.program;
          # Wytnij przed /bin/
          pkgPath = builtins.head (lib.splitString "/bin/" programPath);
        in
        builtins.storePath pkgPath
      )
      config.apps
    );
  };
}