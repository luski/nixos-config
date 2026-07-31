{ config, lib, osConfig, pkgs, ... }:

let
  walkerDotfiles =
    "${config.home.homeDirectory}/nixos-config/dotfiles/walker";
  elephantDotfiles =
    "${config.home.homeDirectory}/nixos-config/dotfiles/elephant";
in
{
  config = lib.mkIf osConfig.desktopSessions.niri.enable {
    home.packages = [
      pkgs.elephant
      pkgs.walker
    ];

    systemd.user.services.elephant = {
      Unit = {
        Description = "Elephant backend for Walker";
        After = [ "graphical-session.target" ];
        PartOf = [ "graphical-session.target" ];
        ConditionEnvironment = "XDG_CURRENT_DESKTOP=niri";
      };

      Service = {
        ExecStart = "${pkgs.elephant}/bin/elephant";
        Restart = "on-failure";
      };

      Install.WantedBy = [ "graphical-session.target" ];
    };

    xdg.configFile = {
      "walker".source =
        config.lib.file.mkOutOfStoreSymlink walkerDotfiles;
      "elephant".source =
        config.lib.file.mkOutOfStoreSymlink elephantDotfiles;
    };
  };
}
