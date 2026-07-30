{
  home = {
    username = "lgo";
    homeDirectory = "/home/lgo";
    stateVersion = "26.05";
  };
  programs.bash.enable = true;
  programs.dank-material-shell = {
    enable = true;
    systemd.enable = true;
  };
}
