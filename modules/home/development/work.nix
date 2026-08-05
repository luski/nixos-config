{
  pkgs,
  lib,
  config,
  ...
}:

let
  pnpmHome = "${config.home.homeDirectory}/.local/share/pnpm";
in
{
  home = {
    packages = with pkgs; [
      fnm
      pnpm
    ];

    sessionPath = [ pnpmHome ];
    sessionVariables.PNPM_HOME = pnpmHome;
  };

  programs.fish = {
    interactiveShellInit = lib.mkAfter ''
      fnm env --use-on-cd --shell fish | source
    '';

    functions = {
      e2e = ''
        set testName $argv[1]
        set browser $argv[2]

        if test -z "$browser"
            set browser chrome
        end

        set -x BROWSER $browser
        set scope (grep -Rl -m 1 $testName test/e2e/tests/ | sed -E 's#.*/tests/([^/]+)/.*#\1#')
        pnpm run pw:$scope --headed --grep=$testName
      '';

      unit = ''
        set phrase $argv[1]
        set param $argv[2]

        set -x BROWSER chrome
        pnpm run test:unit $phrase $param
      '';
    };
  };
}
