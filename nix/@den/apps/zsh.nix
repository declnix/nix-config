{
  den,
  inputs,
  ...
}:
{
  den.aspects.zsh = {
    hjem = { ... }: {
      rum.wrappered.zsh = {
        enable = true;
        inherit inputs;
      };
    };
  };
}
