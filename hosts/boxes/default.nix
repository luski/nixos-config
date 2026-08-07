{
  imports = [
    ../../configuration.nix
    ./hardware-configuration.nix
    ../../modules/nixos/desktop/hyprland.nix
    ../../modules/nixos/desktop/niri.nix
  ];

  networking.hostName = "nixos-boxes";

  boot.loader.grub = {
    enable = true;
    device = "/dev/vda";
    useOSProber = true;
  };
}
