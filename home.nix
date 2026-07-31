{ config, pkgs, ... }:

let
  dotfilesDirectory =
    "${config.home.homeDirectory}/projects/sandbox/nixos-config/dotfiles";
in
{
  home = {
    username = "lgo";
    homeDirectory = "/home/lgo";
    stateVersion = "26.05";
  };

  programs = {
    bash.enable = true;
    dank-material-shell = {
      enable = true;
      systemd.enable = true;
    };

    neovim = {
      enable = true;
      defaultEditor = true;
      extraPackages = with pkgs; [
        fd
        gcc
        ripgrep
      ];
    };

    lazygit.enable = true;
    fish.enable = true;
  };

  xdg.configFile."nvim".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfilesDirectory}/nvim";
}
