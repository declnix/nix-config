{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.hardware.lenovoThinkBook16G4IAP.enable = lib.mkEnableOption "Enable support for Lenovo ThinkBook 16 G4 IAP";

  config = lib.mkIf config.hardware.lenovoThinkBook16G4IAP.enable {
    services.xserver.videoDrivers = [ "intel" ];
    hardware.opengl.extraPackages = with pkgs; [ intel-media-driver ];

    boot.kernelParams = lib.mkBefore [
      "i915.enable_psr=0"
      "i915.enable_fbc=1"
      "i915.modeset=1"
      "nvme.noacpi=1"
    ];

    hardware.cpu.intel.updateMicrocode = lib.mkDefault true;
    services.power-profiles-daemon.enable = true;
    services.thermald.enable = true;
    services.libinput.enable = true;

    hardware.bluetooth.enable = true;
    hardware.bluetooth.package = pkgs.bluez;
    hardware.bluetooth.powerOnBoot = true;

    boot.extraModulePackages = [ pkgs.linuxPackages.uvcvideo ];
    hardware.enableAllFirmware = true;

    systemd.sleep.extraConfig = ''
      SuspendState=mem
    '';

    hardware.sensor.iio.enable = true;

    environment.systemPackages = with pkgs; [
      lm_sensors
      pciutils
      usbutils
      intel-gpu-tools
      powertop
    ];
  };
}
