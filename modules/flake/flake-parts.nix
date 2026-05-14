{
  inputs,
  den,
  ...
}:
{
  flake-file.inputs.treefmt-nix = {
    url = "github:numtide/treefmt-nix";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  imports = [
    (inputs.flake-file.flakeModules.dendritic or { })
    (inputs.den.flakeModules.dendritic or { })
    inputs.treefmt-nix.flakeModule
  ];

  perSystem =
    { pkgs, ... }:
    {
      devShells.default = pkgs.mkShell {
        packages = [
          pkgs.just
        ];

        shellHook = ''
          fix_link() {
            local target="$1"
            local link="$2"

            if [ -e "$link" ] && [ ! -L "$link" ]; then
              rm -rf "$link"
            fi

            ln -sfn "$target" "$link"
          }

          fix_link .workspace/claude .claude
          fix_link .workspace/claude/CLAUDE.md CLAUDE.md

          fix_link .workspace/gemini .gemini
          fix_link .workspace/codex .codex
        '';
      };

      treefmt = {
        projectRootFile = "flake.nix";
        programs.nixfmt.enable = true;
      };
    };

  _module.args.__findFile = den.lib.__findFile;
}
