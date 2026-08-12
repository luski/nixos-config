{ dms, dcal, ... }:
{
  imports = [
    dms.homeModules.dank-material-shell
    dcal.homeModules.dank-calendar
  ];

  programs.dank-material-shell = {
    enable = true;
    systemd.enable = true;
  };

  programs.dank-calendar.enable = true;
}
