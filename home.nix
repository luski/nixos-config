{ pkgs }:
{
  home = {
    username = "lgo";
    homeDirectory = "/home/lgo";
    stateVersion = "26.05";
    shell = pkgs.fish;
  };
  programs = {
    bash.enable = true;
    dank-material-shell = {
      enable = true;
      systemd.enable = true;
    };
    neovim.enable = true;
    lazygit.enable = true;
    fish.enable = true;
  };
}
