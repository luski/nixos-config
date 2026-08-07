{
  services.elephant = {
    enable = true;

    settings = {
      auto_detect_launch_prefix = true;
      git_on_demand = true;

      # Package-manager providers are not useful for this Nix-managed setup.
      ignored_providers = [
        "archlinuxpkgs"
        "dnfpackages"
      ];
    };
  };

  services.walker = {
    enable = true;
    systemd.enable = true;

    settings = {
      close_when_open = true;
      click_to_close = true;
      single_click_activation = true;
      selection_wrap = false;
      theme = "default";

      shell = {
        layer = "overlay";
        anchor_top = true;
        anchor_bottom = true;
        anchor_left = true;
        anchor_right = true;
      };

      columns.symbols = 3;

      placeholders.default = {
        input = "Search";
        list = "No Results";
      };

      providers = {
        default = [
          "desktopapplications"
          "calc"
          "websearch"
        ];
        empty = [ "desktopapplications" ];
        max_results = 50;

        prefixes = [
          {
            prefix = ">";
            provider = "runner";
          }
          {
            prefix = "/";
            provider = "files";
          }
          {
            prefix = ".";
            provider = "symbols";
          }
          {
            prefix = "=";
            provider = "calc";
          }
          {
            prefix = "@";
            provider = "websearch";
          }
          {
            prefix = ":";
            provider = "clipboard";
          }
        ];

        clipboard.time_format = "%d.%m. - %H:%M";
      };
    };
  };
}
