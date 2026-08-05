{
  programs = {
    fish = {
      enable = true;

      shellAbbrs.vim = "nvim";

      interactiveShellInit = ''
        set -g fish_greeting ""
      '';
    };

    zoxide = {
      enable = true;
      enableFishIntegration = true;
    };
  };
}
