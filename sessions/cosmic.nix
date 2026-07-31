{ config, lib, ... }:

{
  options.desktopSessions.cosmic.enable =
    lib.mkEnableOption "COSMIC desktop session";

  config = lib.mkIf config.desktopSessions.cosmic.enable {
    services.desktopManager.cosmic = {
      enable = true;
      xwayland.enable = true;
    };
  };
}
