{ config, pkgs, ... }:

let
  neovimDotfiles =
    "${config.home.homeDirectory}/nixos-config/dotfiles/nvim";
in
{
  home = {
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

  xdg.configFile."nvim".source =
    config.lib.file.mkOutOfStoreSymlink neovimDotfiles;
}
