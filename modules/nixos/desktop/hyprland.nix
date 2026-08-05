{ config, lib, ... }:

{
  options.desktopSessions.hyprland.enable = lib.mkEnableOption "Hyprland desktop session";

  config = lib.mkIf config.desktopSessions.hyprland.enable {
    programs.hyprland = {
      enable = true;
      withUWSM = true;
      xwayland.enable = true;
    };
  };
}
