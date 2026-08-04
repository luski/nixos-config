{ config, lib, pkgs, ... }:

{
  options.desktopSessions.niri.enable =
    lib.mkEnableOption "Niri desktop session";

  config = lib.mkIf config.desktopSessions.niri.enable {
    programs.niri.enable = true;
    programs.niri.package = pkgs.niri;
  };
}
