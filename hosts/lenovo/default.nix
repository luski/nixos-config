{ pkgs, ... }:
{
  imports = [
    ../../configuration.nix
    ./hardware-configuration.nix
    ../../modules/nixos/printing.nix
    ../../modules/nixos/virtualisation.nix
    ../../profiles/niri.nix
  ];

  networking.hostName = "lenovo";

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
    ];
  };

  hardware.bluetooth.enable = true;
}
