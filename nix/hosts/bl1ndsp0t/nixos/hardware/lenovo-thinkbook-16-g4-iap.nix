{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.hardware.lenovoThinkBook16G4IAP.enable = lib.mkEnableOption "Enable support for Lenovo ThinkBook 16 G4 IAP";

  config = lib.mkIf config.hardware.lenovoThinkBook16G4IAP.enable {

    # 🖥️ Intel graphics support
    services.xserver.videoDrivers = [ "intel" ];
    hardware.opengl.extraPackages = with pkgs; [ intel-media-driver ];

    # Kernel parameters for GPU + NVMe + misc quirks
    boot.kernelParams = lib.mkBefore [
      "i915.enable_psr=0"
      "i915.enable_fbc=1"
      "i915.modeset=1"
      "nvme.noacpi=1"
    ];

    # Enable CPU microcode
    hardware.cpu.intel.updateMicrocode = lib.mkDefault true;

    # 🧠 Power and thermal tools
    services.power-profiles-daemon.enable = true;
    services.thermald.enable = true;

    # 🖱️ Touchpad
    services.libinput.enable = true;

    # 📶 WiFi + Bluetooth
    hardware.bluetooth.enable = true;
    hardware.bluetooth.package = pkgs.bluez;
    hardware.bluetooth.powerOnBoot = true;

    # 🎥 Webcam
    boot.extraModulePackages = [ pkgs.linuxPackages.uvcvideo ];

    # 📦 Firmware
    hardware.enableAllFirmware = true;

    # 💤 Suspend config (optional)
    systemd.sleep.extraConfig = ''
      SuspendState=mem
    '';

    # 🌡️ Sensors (optional)
    hardware.sensor.iio.enable = true;

    # 📋 Useful diagnostics
    environment.systemPackages = with pkgs; [
      lm_sensors
      pciutils
      usbutils
      intel-gpu-tools
      powertop
    ];

  };
}
