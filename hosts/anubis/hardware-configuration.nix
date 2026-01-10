{
  config,
  lib,
  modulesPath,
  ...
}:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];
  boot.initrd.availableKernelModules = [
    "xhci_pci"
    "ahci"
    "nvme"
    "usbhid"
    "usb_storage"
    "sd_mod"
    "sr_mod"
  ];
  boot.initrd.kernelModules = [ "amdgpu" ];
  boot.kernelModules = [ "kvm-amd" "sg" ];
  boot.extraModulePackages = [ ];

  #  fileSystems."/" =
  #    { device = "/dev/disk/by-uuid/0309b066-5d6d-4ec4-877c-9864b0124a84";
  #      fsType = "btrfs";
  #      options = [ "subvol=root" "compress=zstd" "noatime" ];
  #    };

  fileSystems."/" = {
    device = "none";
    fsType = "tmpfs";
    options = [
      "size=3G"
      "mode=755"
    ];
  };

  fileSystems."/etc/ssh" = {
    device = "/dev/disk/by-uuid/0309b066-5d6d-4ec4-877c-9864b0124a84";
    fsType = "btrfs";
    options = [
      "subvolid=268"
      "compress=zstd"
      "noatime"
    ];
    neededForBoot = true;
  };

  fileSystems."/home" = {
    device = "/dev/disk/by-uuid/0309b066-5d6d-4ec4-877c-9864b0124a84";
    fsType = "btrfs";
    options = [
      "subvol=home"
      "compress=zstd"
      "noatime"
    ];
  };

  fileSystems."/nix" = {
    device = "/dev/disk/by-uuid/0309b066-5d6d-4ec4-877c-9864b0124a84";
    fsType = "btrfs";
    options = [
      "subvol=nix"
      "compress=zstd"
      "noatime"
    ];
    neededForBoot = true;
  };

  fileSystems."/persist" = {
    device = "/dev/disk/by-uuid/0309b066-5d6d-4ec4-877c-9864b0124a84";
    fsType = "btrfs";
    options = [
      "subvol=persist"
      "compress=zstd"
      "noatime"
    ];
    neededForBoot = true;
  };

  #  fileSystems."/var/log" =
  #    { device = "/dev/disk/by-uuid/0309b066-5d6d-4ec4-877c-9864b0124a84";
  #      fsType = "btrfs";
  #      options = [ "subvol=log" "compress=zstd" "noatime"];
  #      neededForBoot = true;
  #    };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/963B-DEEE";
    fsType = "vfat";
  };

  swapDevices = [
    { device = "/dev/disk/by-uuid/d887e55c-0455-4cdb-b998-bbedb1c2d888"; }
  ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp10s0.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp5s0.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp3s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
