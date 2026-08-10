{
  imports = [
    ../../configuration.nix
    ./hardware-configuration.nix
    ../../profiles/hyprland.nix
    ../../profiles/niri.nix
  ];

  networking.hostName = "nixos-boxes";

  boot.loader.grub = {
    enable = true;
    device = "/dev/vda";
    useOSProber = true;
  };
}
