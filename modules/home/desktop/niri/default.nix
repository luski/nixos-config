{
  config,
  lib,
  osConfig,
  pkgs,
  ...
}:

let
  niriDotfiles = "${config.home.homeDirectory}/nixos-config/modules/home/desktop/niri/config";
  screenshot = pkgs.writeShellApplication {
    name = "screenshot";
    runtimeInputs = with pkgs; [
      coreutils
      swappy
      osConfig.programs.niri.package
    ];
    text = builtins.readFile ./screenshot;
  };
in
{
  config = lib.mkIf osConfig.programs.niri.enable {
    desktopShell.dms.sessions = [ "niri" ];
    home.packages = [ screenshot ];

    xdg.configFile."niri".source = config.lib.file.mkOutOfStoreSymlink niriDotfiles;
  };
}
