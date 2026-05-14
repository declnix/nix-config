{
  den.aspects.libvirt = {
    nixos = {
      virtualisation = {
        libvirtd.enable = true;
      };

      programs.virt-manager.enable = true;
    };
  };
}
