{ den, ... }:
{
  den.aspects.dev-ai = {
    hjem =
      { pkgs, ... }:
      {
        packages = [
          pkgs.claude-code
          pkgs.gemini-cli
        ];
      };
  };

  den.default.includes = [ (den._.unfree [ "claude-code" ]) ];
}
