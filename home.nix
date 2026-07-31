{ config, pkgs, ... }:

let
  dotfilesDirectory = "${config.home.homeDirectory}/nixos-config/dotfiles";
in
{
  imports = [
    ./kitty.nix
  ];

  home = {
    username = "lgo";
    homeDirectory = "/home/lgo";
    stateVersion = "26.05";

    packages = with pkgs; [
      fd
      gcc
      neovim
      ripgrep
    ];

    sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };
  };

  programs = {
    bash.enable = true;
    dank-material-shell = {
      enable = true;
      systemd.enable = true;
    };

    lazygit.enable = true;
    fish.enable = true;
  };

  xdg.configFile."nvim".source = config.lib.file.mkOutOfStoreSymlink "${dotfilesDirectory}/nvim";
}
