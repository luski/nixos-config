{
  imports = [
    ./browsers
    ./sessions/home.nix
    ./utils
  ];

  home = {
    username = "lgo";
    homeDirectory = "/home/lgo";
    stateVersion = "26.05";
  };

  programs = {
    bash.enable = true;
    lazygit.enable = true;
    fish.enable = true;
  };
}
