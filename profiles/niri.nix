{ pkgs, ... }:

{
  programs.niri.enable = true;

  # Niri discovers this at session startup and then provides DISPLAY plus
  # on-demand XWayland support for X11-only clients such as Dropbox's tray.
  environment.systemPackages = [ pkgs.xwayland-satellite ];

  home-manager.users.lgo.imports = [
    ../modules/home/desktop/niri
    ../modules/home/desktop/niri/niri-dms.nix
    ../modules/home/desktop/dms.nix
  ];
}
