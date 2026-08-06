{
  imports = [
    ./modules/home/neovim.nix
    ./modules/home/kitty.nix
    ./modules/home/fish.nix
    ./modules/home/development/work.nix
    ./modules/home/nautilus.nix
    ./modules/home/foot.nix
    ./modules/home/browsers/firefox.nix
    ./modules/home/browsers/google-chrome.nix
    ./modules/home/browsers/helium.nix
    ./modules/home/browsers/zen-browser.nix
    ./modules/home/desktop/niri.nix
    ./modules/home/desktop/hyprland.nix
    ./modules/home/desktop/dms.nix
    ./modules/home/dropbox.nix

  ];

  home = {
    username = "lgo";
    homeDirectory = "/home/lgo";
    stateVersion = "26.05";
  };

  programs = {
    bash.enable = true;
    lazygit.enable = true;
  };
}
