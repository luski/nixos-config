{
  imports = [
    ./sessions/hyprland/home.nix
    ./sessions/niri/home.nix
    ./utils/dms.nix
    ./utils/kitty.nix
    ./utils/neovim.nix
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
