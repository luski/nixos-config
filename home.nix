{
  imports = [
    ./modules/home/neovim
    ./modules/home/kitty
    ./modules/home/fish.nix
    ./modules/home/work
    ./modules/home/nautilus.nix
    ./modules/home/foot.nix
    ./modules/home/browsers/firefox.nix
    ./modules/home/browsers/google-chrome.nix
    ./modules/home/browsers/helium.nix
    ./modules/home/browsers/zen-browser.nix
    ./modules/home/desktop/niri
    ./modules/home/desktop/hyprland.nix
    ./modules/home/desktop/dms.nix
    ./modules/home/desktop/walker.nix
    ./modules/home/dropbox.nix
    ./modules/home/obsidian.nix
    ./modules/home/scripts/to-webp

    ./modules/home/graphics/gimp.nix
    ./modules/home/graphics/inkscape.nix
    ./modules/home/graphics/krita.nix
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
