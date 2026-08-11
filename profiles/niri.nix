{ config, pkgs, ... }:

let
  screenshot = pkgs.writeShellApplication {
    name = "screenshot";
    runtimeInputs = with pkgs; [
      coreutils
      satty
      config.programs.niri.package
    ];
    text = builtins.readFile ../modules/home/desktop/niri/screenshot;
  };
in
{
  programs.niri.enable = true;

  # Niri discovers this at session startup and then provides DISPLAY plus
  # on-demand XWayland support for X11-only clients such as Dropbox's tray.
  environment.systemPackages = [ pkgs.xwayland-satellite ];

  home-manager.users.lgo =
    { config, ... }:

    let
      niriConfigFile = "${config.home.homeDirectory}/nixos-config/modules/home/desktop/niri/config/config.kdl";
      niriConfigCustomizationDir = "${config.home.homeDirectory}/nixos-config/modules/home/desktop/niri/config/custom";
    in
    {
      imports = [
        ../modules/home/desktop/niri/niri-dms.nix
      ];
      home.packages = [ screenshot ];

      xdg.configFile."niri/config.kdl".source = config.lib.file.mkOutOfStoreSymlink niriConfigFile;
      xdg.configFile."niri/custom".source =
        config.lib.file.mkOutOfStoreSymlink niriConfigCustomizationDir;
    };

}
