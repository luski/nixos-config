{ lib, osConfig, ... }:

{
  imports = [
    ./config.nix
    ./walker.nix
  ];

  config = lib.mkIf osConfig.desktopSessions.niri.enable {
    desktopShell.dms.sessions = [ "niri" ];
  };
}
