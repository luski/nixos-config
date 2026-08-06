{ pkgs, ... }:

{
  home.packages = [ pkgs.dropbox ];

  systemd.user.services.dropbox = {
    Unit = {
      Description = "Dropbox desktop client";
      After = [
        "graphical-session.target"
        "dms.service"
      ];
      PartOf = [ "graphical-session.target" ];
    };

    Service = {
      ExecStart = "${pkgs.dropbox}/bin/dropbox";
      Restart = "on-failure";
      RestartSec = 5;
    };

    Install.WantedBy = [ "graphical-session.target" ];
  };
}
