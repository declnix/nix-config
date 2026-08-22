{ config, lib, ... }:
let
  fileType = lib.types.submodule (
    { name, ... }:
    {
      options = {
        text = lib.mkOption {
          type = lib.types.lines;
          description = "Template text rendered with envsubst before installation.";
        };

        target = lib.mkOption {
          type = lib.types.strMatching "/.*";
          readOnly = true;
          default = name;
          description = "Absolute path where the rendered runtime file is installed, derived from the attribute name.";
        };

        mode = lib.mkOption {
          type = lib.types.str;
          default = "0644";
          description = "File mode passed to install.";
        };
      };
    }
  );
in
{
  options.host-files = lib.mkOption {
    type = lib.types.attrsOf (lib.types.attrsOf fileType);
    default = { };
    description = "Host-scoped files rendered from environment variables.";
  };

  config = {
    perSystem = { pkgs, ... }:
      let
        installHostFiles = lib.concatStringsSep "\n" (
          lib.mapAttrsToList
            (
              host: files:
                ''
                  ${lib.escapeShellArg host})
                  printf '\033[1;32mwriting files\033[0m\n'
                  sudo -v

                ''
                + lib.concatStringsSep "\n" (
                  lib.mapAttrsToList
                    (
                      target: file:
                        let
                          templateName =
                            "file-${host}-${builtins.hashString "sha256" target}.tmpl";
                          template = pkgs.writeText templateName file.text;
                        in
                        ''
                          printf 'installing %s\n' ${lib.escapeShellArg file.target}
                          envsubst < ${lib.escapeShellArg template} \
                            | sudo install --compare -D -m ${lib.escapeShellArg file.mode} /dev/stdin ${lib.escapeShellArg file.target}
                        ''
                    )
                    files
                )
                + ''
                  ;;
                ''
            )
            config.host-files
        );

        write-host-files = pkgs.writeShellApplication {
          name = "write-host-files";
          runtimeInputs = with pkgs; [
            coreutils
            gettext
          ];
          text = ''
            host="''${HOST:-$(hostname)}"
            export HOST="$host"

            case "$host" in
            ${installHostFiles}
              *)
                ;;
            esac
          '';
        };
      in
      {
        apps.write-host-files = {
          type = "app";
          program = lib.getExe write-host-files;
          meta.description = "Render and install host-scoped file templates.";
        };

        packages.write-host-files = write-host-files;
      };
  };
}
