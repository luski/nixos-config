{
  imports = [
    ../modules/nixos/desktop/hyprland.nix
  ];

  home-manager.users.lgo.imports = [
    ../modules/home/desktop/dms.nix
  ];
}
