{
  imports = [
    ../modules/nixos/desktop/niri.nix
  ];

  home-manager.users.lgo.imports = [
    ../modules/home/desktop/niri
    ../modules/home/desktop/dms.nix
  ];
}
