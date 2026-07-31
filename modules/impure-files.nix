{ config, lib, ... }:
let
  fileType = lib.types.submodule (
    { name, ... }:
    {
      options = {
        text = lib.mkOption {
          type = lib.types.lines;
          description = "Impure template text rendered with envsubst before installation.";
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
  options.impure-files.hosts = lib.mkOption {
    type = lib.types.attrsOf (lib.types.attrsOf fileType);
    default = { };
    description = "Host-scoped impure files rendered from environment variables.";
  };

  config = {
    perSystem = { pkgs, ... }:
      let
        installImpureFiles = lib.concatStringsSep "\n" (
          lib.mapAttrsToList
            (
              host: files:
                ''
                  ${lib.escapeShellArg host})
                  printf '\033[1;32mwriting impure files\033[0m\n'
                  sudo -v

                ''
                + lib.concatStringsSep "\n" (
                  lib.mapAttrsToList
                    (
                      target: file:
                        let
                          templateName =
                            "impure-file-${host}-${builtins.hashString "sha256" target}.tmpl";
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
            config.impure-files.hosts
        );

        emit-impure-files = pkgs.writeShellApplication {
          name = "emit-impure-files";
          runtimeInputs = with pkgs; [
            coreutils
            gettext
          ];
          text = ''
            host="''${HOST:-$(hostname)}"
            export HOST="$host"

            case "$host" in
            ${installImpureFiles}
              *)
                ;;
            esac
          '';
        };
      in
      {
        apps.emit-impure-files = {
          type = "app";
          program = lib.getExe emit-impure-files;
          meta.description = "Render and install host-scoped impure file templates.";
        };

        packages.emit-impure-files = emit-impure-files;
      };
  };
}
