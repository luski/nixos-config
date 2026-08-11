{
  config,
  osConfig,
  pkgs,
  ...
}:

let
  niriConfigFile = "${config.home.homeDirectory}/nixos-config/modules/home/desktop/niri/config/config.kdl";
  niriConfigCustomizationDir = "${config.home.homeDirectory}/nixos-config/modules/home/desktop/niri/config/custom";
  screenshot = pkgs.writeShellApplication {
    name = "screenshot";
    runtimeInputs = with pkgs; [
      coreutils
      satty
      osConfig.programs.niri.package
    ];
    text = builtins.readFile ./screenshot;
  };
in
{
  home.packages = [ screenshot ];

  xdg.configFile."niri/config.kdl".source = config.lib.file.mkOutOfStoreSymlink niriConfigFile;
  xdg.configFile."niri/custom".source =
    config.lib.file.mkOutOfStoreSymlink niriConfigCustomizationDir;
}
