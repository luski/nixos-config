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
  home.packages = with pkgs; [
    firefox
    google-chrome
    helium.packages.${system}.helium
    zen-browser.packages.${system}.default
  ];
}
