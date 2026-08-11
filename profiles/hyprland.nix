{
  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
  };

  home-manager.users.lgo.imports = [
    ../modules/home/desktop/dms.nix
  ];
}
