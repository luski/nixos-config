{ config, lib, osConfig, ... }:

let
  niriDotfiles =
    "${config.home.homeDirectory}/nixos-config/dotfiles/niri";
in
{
  imports = [
    ./walker.nix
  ];

  config = lib.mkIf osConfig.desktopSessions.niri.enable {
    desktopShell.dms.sessions = [ "niri" ];

    xdg.configFile."niri".source =
      config.lib.file.mkOutOfStoreSymlink niriDotfiles;
  };
}
