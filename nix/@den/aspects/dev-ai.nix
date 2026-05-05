{den, ...}: {
  den.aspects.dev-ai = {
    hjem = {pkgs, ...}: {
      packages = [pkgs.claude-code];
    };
  };

  den.default.includes = [(den._.unfree ["claude-code"])];
}
