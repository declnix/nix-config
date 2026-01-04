# @skip
{
  imports = [
    # @macro :: \
    #   grep -rl '@plugins' . \
    #   | xargs grep -L '@skip' \
    #   | sort
    ./config/keymaps.nix
    ./config/languages/markdown.nix
    ./config/plugins.nix
    ./config/ui.nix
    # @end
  ];
}
