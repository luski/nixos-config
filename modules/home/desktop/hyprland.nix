{ lib, osConfig, ... }:

{
  config = lib.mkIf osConfig.programs.hyprland.enable {
    desktopShell.dms.sessions = [ "Hyprland" ];
  };
}
