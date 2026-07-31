{
  helium,
  pkgs,
  zen-browser,
  ...
}:

let
  system = pkgs.stdenv.hostPlatform.system;
in
{
  home.packages = [
    pkgs.firefox
    pkgs.google-chrome
    helium.packages.${system}.helium
    zen-browser.packages.${system}.default
  ];
}
