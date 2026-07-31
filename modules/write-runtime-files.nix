{ lib, ... }:
{
  perSystem = { pkgs, ... }:
    let
      write-runtime-files = pkgs.writeShellApplication {
        name = "write-runtime-files";
        runtimeInputs = with pkgs; [
          coreutils
          findutils
          gettext
          sudo
        ];
        text = ''
          host="''${DEPLOY_HOST:-$(hostname)}"

          sudo -v

          while IFS= read -r -d "" template; do
            case "$template" in
              */"$host"/*) ;;
              *) continue ;;
            esac

            first_line="$(head -n 1 "$template")"
            case "$first_line" in
              "# target: "/*) ;;
              *) continue ;;
            esac

            target="''${first_line#"# target: "}"

            tail -n +2 "$template" \
              | envsubst \
              | sudo install --compare -D -m 0644 /dev/stdin "$target"
          done < <(find . -type f -name "*.tmpl" -print0)
        '';
      };
    in
    {
      apps.write-runtime-files = {
        type = "app";
        program = lib.getExe write-runtime-files;
        meta.description = "Render and install host-scoped runtime file templates.";
      };

      packages.write-runtime-files = write-runtime-files;
    };
}
