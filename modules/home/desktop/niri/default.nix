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
  config = lib.mkIf osConfig.programs.niri.enable {
    desktopShell.dms.sessions = [ "niri" ];

    xdg.configFile."niri".source = config.lib.file.mkOutOfStoreSymlink niriDotfiles;
  };
}
