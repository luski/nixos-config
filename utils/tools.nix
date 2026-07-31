{ pkgs, ... }:

{
  home.packages = [
    pkgs.statix
  ];

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };
}
