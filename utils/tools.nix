{ pkgs, ... }:

{
  home.packages = with pkgs; [
    nautilus
    foot
  ];

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };
}
