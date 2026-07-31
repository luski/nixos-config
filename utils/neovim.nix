{ config, pkgs, ... }:

let
  neovimDotfiles = "${config.home.homeDirectory}/nixos-config/dotfiles/nvim";
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
      tree-sitter
      wl-clipboard

      # Formatters configured in lua/plugins/conform.lua.
      biome
      kdlfmt
      prettierd
      shfmt
      stylua

      # Linters enabled by LazyVim extras.
      hadolint
      shellcheck

      # Toolchains and language servers enabled in lazyvim.json.
      astro-language-server
      bash-language-server
      cargo
      chezmoi
      clang-tools
      docker-compose-language-service
      docker-language-server
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

  xdg.configFile."nvim".source = config.lib.file.mkOutOfStoreSymlink neovimDotfiles;
}
