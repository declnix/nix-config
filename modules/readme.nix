{ flake-parts-lib, ... }:
{
  options.perSystem = flake-parts-lib.mkPerSystemOption ({ config, lib, ... }: {
    options.readme = lib.mkOption {
      type = lib.types.listOf lib.types.lines;
      default = [ ];
      description = "Fragments used to generate README.md.";
    };

    config = {
      readme = lib.mkOrder 100 [
        ''
          # ❄️ My Nix Configuration

          My dotfiles, mostly NixOS these days.

          This is where I keep machine configs, shell/editor bits, and whatever glue helps me get my work done.
        ''
      ];

      files.file."README.md".text =
        lib.concatStringsSep "\n\n" (map (lib.removeSuffix "\n") config.readme) + "\n";
    };
  });
}
