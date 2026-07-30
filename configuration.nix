{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];
  # Bootloader.
  boot = {
    loader = {
      grub = {
        enable = true;
        device = "/dev/sda";
        useOSProber = true;
      };
    };

    # Use latest kernel.
    kernelPackages = pkgs.linuxPackages_latest;
  };

  networking.hostName = "nixos"; # Define your hostname.

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Warsaw";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pl_PL.UTF-8";
    LC_IDENTIFICATION = "pl_PL.UTF-8";
    LC_MEASUREMENT = "pl_PL.UTF-8";
    LC_MONETARY = "pl_PL.UTF-8";
    LC_NAME = "pl_PL.UTF-8";
    LC_NUMERIC = "pl_PL.UTF-8";
    LC_PAPER = "pl_PL.UTF-8";
    LC_TELEPHONE = "pl_PL.UTF-8";
    LC_TIME = "pl_PL.UTF-8";
  };

  # Configure console keymap
  console.keyMap = "pl2";

  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
  };
  programs.fish.enable = true;

  services.greetd = {
    enable = true;
    settings = {
      initial_session = {
        command = "${pkgs.uwsm}/bin/uwsm start hyprland-uwsm.desktop";
        user = "lgo";
      };
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --time --cmd '${pkgs.uwsm}/bin/uwsm start hyprland-uwsm.desktop'";
        user = "greeter";
      };
    };
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."lgo" = {
    isNormalUser = true;
    description = "lgo";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    shell = pkgs.fish;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    git
    gh
    kitty
  ];

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  system.stateVersion = "26.11"; # Did you read the comment?
}
