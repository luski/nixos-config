{ lib, osConfig, ... }:

{
  config = lib.mkIf osConfig.desktopSessions.hyprland.enable {
    desktopShell.dms.sessions = [ "Hyprland" ];
  };
}
