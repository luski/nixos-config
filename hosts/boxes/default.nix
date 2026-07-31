{
  imports = [
    ../../configuration.nix
    ./hardware-configuration.nix
  ];

  networking.hostName = "nixos-boxes";

  desktopSessions = {
    cosmic.enable = false;
    hyprland.enable = true;
    niri.enable = true;
  };

  boot.loader.grub = {
    enable = true;
    device = "/dev/vda";
    useOSProber = true;
  };
}
