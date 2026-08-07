{ config, pkgs, ... }:

let
  kittyDotfiles = "${config.home.homeDirectory}/nixos-config/modules/home/kitty/config";
in
{
  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    kitty
    nerd-fonts.jetbrains-mono
    victor-mono
  ];

  xdg.configFile."kitty".source = config.lib.file.mkOutOfStoreSymlink kittyDotfiles;
}
