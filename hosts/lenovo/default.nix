{
  imports = [
    ../../configuration.nix
    ./hardware-configuration.nix
    ../../modules/nixos/printing.nix
  ];

  networking.hostName = "lenovo";

  desktopSessions = {
    cosmic.enable = false;
    hyprland.enable = false;
    niri.enable = true;
  };

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };
}
