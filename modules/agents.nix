{ flake-parts-lib, ... }:
{
  options.perSystem = flake-parts-lib.mkPerSystemOption ({ config, lib, ... }: {
    options.agents.instructions = lib.mkOption {
      type = lib.types.listOf lib.types.lines;
      default = [ ];
      description = "Fragments used to generate AGENTS.md.";
    };

    config = {
      agents.instructions = lib.mkOrder 100 [
        ''
          # Global Instructions

          - If a Nix operation needs a newly created file, stage that path first with `git add <path>`; untracked files are invisible to Nix flakes.
        ''
      ];

      files.file."AGENTS.md".text =
        lib.concatStringsSep "\n\n" (map (lib.removeSuffix "\n") config.agents.instructions) + "\n";
    };
  });
}
