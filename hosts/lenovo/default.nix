{
  imports = [
    ../../configuration.nix
    ./hardware-configuration.nix
    ../../modules/nixos/printing.nix
    ../../modules/nixos/desktop/niri.nix
  ];

  networking.hostName = "lenovo";

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };
}
