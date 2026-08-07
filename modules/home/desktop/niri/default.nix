{
  config,
  lib,
  osConfig,
  ...
}:

let
  niriDotfiles = "${config.home.homeDirectory}/nixos-config/modules/home/desktop/niri/config";
in
{
  imports = [
    ../walker.nix
  ];

  config = lib.mkIf osConfig.desktopSessions.niri.enable {
    desktopShell.dms.sessions = [ "niri" ];

    xdg.configFile."niri".source = config.lib.file.mkOutOfStoreSymlink niriDotfiles;
  };
}
