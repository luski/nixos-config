{ pkgs, ... }:

{
  home.packages = with pkgs; [
    statix
    nautilus
  ];

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };
}
