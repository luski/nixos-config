{
  imports = [
    ../../configuration.nix
    ./hardware-configuration.nix
  ];

  networking.hostName = "nixos-boxes";

  boot.loader.grub = {
    enable = true;
    device = "/dev/vda";
    useOSProber = true;
  };
}
