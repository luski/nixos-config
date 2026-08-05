{ config, lib, ... }:

let
  cfg = config.desktopShell.dms;
in
{
  options.desktopShell.dms.sessions = lib.mkOption {
    type = lib.types.listOf lib.types.str;
    default = [ ];
    description = "Desktop sessions in which DMS should run.";
  };

  config = lib.mkIf (cfg.sessions != [ ]) {
    programs.dank-material-shell = {
      enable = true;
      systemd.enable = true;
    };

    # A leading "|" makes these systemd conditions alternatives (OR).
    systemd.user.services.dms.Unit.ConditionEnvironment = map (
      session: "|XDG_CURRENT_DESKTOP=${session}"
    ) cfg.sessions;
  };
}
