{ pkgs, ... }:

{
  imports = [
    ./sessions
  ];

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Enable networking
  networking.networkmanager.enable = true;

  # Expose laptop battery information over D-Bus for desktop widgets.
  services.upower.enable = true;

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

  programs.fish.enable = true;

  services.greetd = {
    enable = true;

    settings.default_session = {
      command = "${pkgs.tuigreet}/bin/tuigreet --time --remember --remember-user-session";
      user = "greeter";
    };
  };

  # Allow tuigreet to remember the last user and selected session.
  systemd.tmpfiles.rules = [
    "d /var/cache/tuigreet 0755 greeter greeter -"
  ];

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
  ];

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  system.stateVersion = "26.11"; # Did you read the comment?
}
