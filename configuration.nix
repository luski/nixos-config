{ pkgs, ... }:

{
  imports = [
    ./modules/nixos/greetd.nix
    ./modules/nixos/users/lgo.nix
    ./modules/nixos/localization.nix
    ./modules/nixos/networking.nix
  ];

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  services = {

    # Expose laptop battery information over D-Bus for desktop widgets.
    upower.enable = true;

    power-profiles-daemon.enable = true;

    # Enable the OpenSSH daemon.
    openssh.enable = true;
  };

  # Give PipeWire and WirePlumber access to realtime scheduling.
  security.rtkit.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    git
    gh
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  system.stateVersion = "26.11"; # Did you read the comment?

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 14d";
  };
}
