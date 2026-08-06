{ pkgs, ... }:

{
  users.users."lgo" = {
    isNormalUser = true;
    description = "lgo";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    shell = pkgs.fish;
  };

  programs.fish.enable = true;
}
