{ lib, osConfig, ... }:

{
  config = lib.mkIf osConfig.desktopSessions.niri.enable {
    desktopShell.dms.sessions = [ "niri" ];
  };
}
