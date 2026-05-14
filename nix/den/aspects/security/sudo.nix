{ ... }:
{
  den.aspects.sudo = {
    nixos = {
      security.sudo.enable = true;
      security.sudo.wheelNeedsPassword = false;
    };
  };
}
