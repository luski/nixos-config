{ pkgs, ... }:

{
  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    victor-mono
  ];

  programs.kitty = {
    enable = true;

    settings = {
      font_family = "family=\"JetBrainsMono Nerd Font\" style=ExtraLight";
      bold_font = "auto";
      italic_font = "Victor Mono Italic";
      bold_italic_font = "Victor Mono Bold Italic";
      font_size = 11;
      enable_ligatures = "yes";

      tab_bar_style = "powerline";
      tab_powerline_style = "round";

      editor = "nvim";
      background_blur = 1;
      background_opacity = 0.7;

      enabled_layouts = "tall, fat, stack";

      allow_remote_control = "yes";
      listen_on = "unix:@mykitty";
    };

    keybindings = {
      "ctrl+a>t>t" = "detach_window new-tab";
      "ctrl+a>t>shift+t" = "detach_window tab-left";

      "ctrl+." = "layout_action bias 50 70";
      "--allow-fallback=shifted,ascii ctrl+shift+l" = "next_layout";

      "ctrl+a>l" = "next_layout";
      "ctrl+a>\\" = "launch --cwd=current";
      "ctrl+a>c" = "launch --cwd=current --type=tab";
      "ctrl+a>n" = "next_tab";

      "ctrl+shift+h" = "neighboring_window left";
      "ctrl+shift+l" = "neighboring_window right";

      "ctrl+h" = "neighboring_window left";
      "ctrl+j" = "neighboring_window down";
      "ctrl+k" = "neighboring_window up";
      "ctrl+l" = "neighboring_window right";

      "--when-focus-on var:IS_VIM=true ctrl+h" = "";
      "--when-focus-on var:IS_VIM=true ctrl+j" = "";
      "--when-focus-on var:IS_VIM=true ctrl+k" = "";
      "--when-focus-on var:IS_VIM=true ctrl+l" = "";
    };

    # This Kitty option occurs twice, so it cannot be represented by a
    # single Nix attribute.
    extraConfig = ''
      modify_font cell_height 6px
      modify_font cell_width 102%
    '';
  };
}
