{ config, lib, ... }:

{
  imports = [
    ./cosmic.nix
    ./hyprland
    ./niri
  ];

  assertions = [
    {
      assertion =
        config.desktopSessions.cosmic.enable
        || config.desktopSessions.hyprland.enable
        || config.desktopSessions.niri.enable;
      message = "At least one desktop session must be enabled.";
    }
  ];
}
