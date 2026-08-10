{ pkgs, ... }:
{
  imports = [
    ../../configuration.nix
    ./hardware-configuration.nix
    ../../modules/nixos/printing.nix
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
}
