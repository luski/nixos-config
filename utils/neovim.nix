{ config, pkgs, ... }:

let
  neovimDotfiles =
    "${config.home.homeDirectory}/nixos-config/dotfiles/nvim";
in
{
  home = {
    packages = with pkgs; [
      # Tools used directly by the configuration and LazyVim itself.
      fd
      fzf
      gcc
      git
      neovim
      nodejs
      ripgrep
      wl-clipboard

      # Formatters configured in lua/plugins/conform.lua.
      biome
      kdlfmt
      prettierd

      # Toolchains and language servers enabled in lazyvim.json.
      astro-language-server
      cargo
      chezmoi
      clang-tools
      graphviz
      marksman
      nixd
      nixfmt
      rust-analyzer
      rustc
      tailwindcss-language-server
      taplo
      typescript
      typescript-language-server
      vscode-langservers-extracted
      vue-language-server
    ];

    sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };
  };

  xdg.configFile."nvim".source =
    config.lib.file.mkOutOfStoreSymlink neovimDotfiles;
}
