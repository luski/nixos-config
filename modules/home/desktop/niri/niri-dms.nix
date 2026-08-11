{ config, ... }:

{
  xdg.configFile."niri/dms".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-config/modules/home/desktop/niri/config/dms";
}
