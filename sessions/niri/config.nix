{ lib, osConfig, ... }:

let
  action = name: value: { action.${name} = value; };
  noArgs = name: action name [ ];
  spawn = command: action "spawn" command;
  spawnSh = command: action "spawn-sh" command;

  numberedWorkspaceBinds = builtins.listToAttrs (
    map (
      number:
      lib.nameValuePair "Mod+${toString number}" (
        action "focus-workspace" number
      )
    ) (lib.range 1 9)
  );

  numberedWorkspaceMoveBinds = builtins.listToAttrs (
    map (
      number:
      lib.nameValuePair "Mod+Shift+${toString number}" (
        action "move-column-to-workspace" number
      )
    ) (lib.range 1 9)
  );

  cornerRadius = {
    top-left = 12.0;
    top-right = 12.0;
    bottom-left = 12.0;
    bottom-right = 12.0;
  };
in
{
  config = lib.mkIf osConfig.desktopSessions.niri.enable {
    programs.dank-material-shell.niri.includes = {
      enable = true;
      filesToInclude = [
        "alttab"
        "binds"
        "colors"
        "cursor"
        "layout"
        "outputs"
        "windowrules"
        "wpblur"
        "custom"
      ];
    };

    # recent-windows is newer than the typed niri-flake schema. Keep this
    # small escape hatch as an extra include managed by Home Manager.
    xdg.configFile."niri/dms/custom.kdl".text = ''
      recent-windows {
          binds {
              Alt+Tab         { next-window scope="output"; }
              Alt+Shift+Tab   { previous-window scope="output"; }
              Alt+grave       { next-window filter="app-id"; }
              Alt+Shift+grave { previous-window filter="app-id"; }
          }
      }
    '';

    programs.niri.settings = {
      gestures.hot-corners.enable = false;

      input = {
        keyboard = {
          numlock = true;
          xkb.layout = "pl";
        };
        touchpad.tap = true;
        warp-mouse-to-focus.enable = true;
        focus-follows-mouse = {
          enable = true;
          max-scroll-amount = "10%";
        };
      };

      layout = {
        gaps = 4;
        background-color = "transparent";
        always-center-single-column = true;
        center-focused-column = "never";
        preset-column-widths = [
          { proportion = 0.33333; }
          { proportion = 0.5; }
          { proportion = 0.66667; }
        ];
        default-column-width.proportion = 0.5;

        border = {
          enable = false;
          width = 2;
          active.color = "#707070";
          inactive.color = "#d0d0d0";
          urgent.color = "#cc4444";
        };

        focus-ring.width = 2;

        shadow = {
          enable = true;
          softness = 30;
          spread = 5;
          offset = {
            x = 0;
            y = 5;
          };
          color = "#0007";
        };
      };

      layer-rules = [
        {
          matches = [ { namespace = "^quickshell$"; } ];
          place-within-backdrop = true;
        }
      ];

      overview.workspace-shadow.enable = false;
      prefer-no-csd = true;
      screenshot-path = "~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png";

      animations = {
        workspace-switch.kind.spring = {
          damping-ratio = 0.80;
          stiffness = 523;
          epsilon = 0.0001;
        };
        window-open.kind.easing = {
          duration-ms = 150;
          curve = "ease-out-expo";
        };
        window-close.kind.easing = {
          duration-ms = 150;
          curve = "ease-out-quad";
        };
        horizontal-view-movement.kind.spring = {
          damping-ratio = 0.85;
          stiffness = 423;
          epsilon = 0.0001;
        };
        window-movement.kind.spring = {
          damping-ratio = 0.75;
          stiffness = 323;
          epsilon = 0.0001;
        };
        window-resize.kind.spring = {
          damping-ratio = 0.85;
          stiffness = 423;
          epsilon = 0.0001;
        };
        config-notification-open-close.kind.spring = {
          damping-ratio = 0.65;
          stiffness = 923;
          epsilon = 0.001;
        };
        screenshot-ui-open.kind.easing = {
          duration-ms = 200;
          curve = "ease-out-quad";
        };
        overview-open-close.kind.spring = {
          damping-ratio = 0.85;
          stiffness = 800;
          epsilon = 0.0001;
        };
      };

      window-rules = [
        {
          matches = [ { app-id = "^org\\.gnome\\."; } ];
          draw-border-with-background = false;
          geometry-corner-radius = cornerRadius;
          clip-to-geometry = true;
        }
        {
          matches = map (app-id: { inherit app-id; }) [
            "^org\\.gnome\\.Calculator$"
            "^app\\.drey\\.Dialect$"
            "^org\\.kde\\.kruler$"
            "^xdg-desktop-portal$"
          ];
          open-floating = true;
        }
        {
          matches = [ { app-id = "^kitty$"; } ];
          draw-border-with-background = false;
        }
        {
          matches = [
            {
              app-id = "^firefox$";
              title = "^Picture-in-Picture$";
            }
            { app-id = "^zoom$"; }
          ];
          open-floating = true;
        }
        {
          geometry-corner-radius = cornerRadius;
          clip-to-geometry = true;
          tiled-state = true;
          draw-border-with-background = false;
        }
      ];

      workspaces = {
        browser = { };
        development = { };
        email = { };
        chats = { };
      };

      binds = {
        "Mod+N" = spawnSh "kitty -e nvim" // {
          hotkey-overlay.title = "nvim";
        };
        "Mod+Tab" = noArgs "toggle-overview" // { repeat = false; };
        "Mod+Shift+Slash" = noArgs "show-hotkey-overlay";

        "Mod+Return" = spawn "kitty" // {
          hotkey-overlay.title = "Open Terminal";
        };
        "Mod+Space" = spawn "walker" // {
          hotkey-overlay.title = "Application Launcher";
        };
        "Mod+V" = spawn [ "walker" "-m" "clipboard" ] // {
          hotkey-overlay.title = "Clipboard Manager Walker";
        };
        "Mod+E" = spawn [ "walker" "-m" "symbols" ] // {
          hotkey-overlay.title = "Emoji";
        };
        "Mod+Shift+F" = spawn "nautilus" // {
          hotkey-overlay.title = "File manager";
        };

        "Mod+Shift+E" = noArgs "quit";
        "Mod+Q" = noArgs "close-window" // { repeat = false; };
        "Mod+F" = noArgs "maximize-column";
        "Mod+Shift+T" = noArgs "toggle-window-floating";
        "Mod+Shift+V" = noArgs "switch-focus-between-floating-and-tiling";
        "Mod+W" = noArgs "toggle-column-tabbed-display";

        "Mod+Left" = noArgs "focus-column-left";
        "Mod+Down" = noArgs "focus-window-down";
        "Mod+Up" = noArgs "focus-window-up";
        "Mod+Right" = noArgs "focus-column-right";
        "Mod+H" = noArgs "focus-column-left";
        "Mod+J" = noArgs "focus-window-down";
        "Mod+K" = noArgs "focus-window-up";
        "Mod+L" = noArgs "focus-column-right";

        "Mod+Shift+Left" = noArgs "move-column-left";
        "Mod+Shift+Down" = noArgs "move-window-down";
        "Mod+Shift+Up" = noArgs "move-window-up";
        "Mod+Shift+Right" = noArgs "move-column-right";
        "Mod+Shift+H" = noArgs "move-column-left";
        "Mod+Shift+J" = noArgs "move-window-down";
        "Mod+Shift+K" = noArgs "move-window-up";
        "Mod+Shift+L" = noArgs "move-column-right";

        "Mod+Home" = noArgs "focus-column-first";
        "Mod+End" = noArgs "focus-column-last";
        "Mod+Ctrl+Home" = noArgs "move-column-to-first";
        "Mod+Ctrl+End" = noArgs "move-column-to-last";

        "Mod+Ctrl+H" = noArgs "focus-monitor-left";
        "Mod+Ctrl+J" = noArgs "focus-monitor-down";
        "Mod+Ctrl+K" = noArgs "focus-monitor-up";
        "Mod+Ctrl+L" = noArgs "focus-monitor-right";

        "Mod+Shift+Ctrl+Left" = noArgs "move-column-to-monitor-left";
        "Mod+Shift+Ctrl+Down" = noArgs "move-column-to-monitor-down";
        "Mod+Shift+Ctrl+Up" = noArgs "move-column-to-monitor-up";
        "Mod+Shift+Ctrl+Right" = noArgs "move-column-to-monitor-right";
        "Mod+Shift+Ctrl+H" = noArgs "move-column-to-monitor-left";
        "Mod+Shift+Ctrl+J" = noArgs "move-column-to-monitor-down";
        "Mod+Shift+Ctrl+K" = noArgs "move-column-to-monitor-up";
        "Mod+Shift+Ctrl+L" = noArgs "move-column-to-monitor-right";

        "Mod+Page_Down" = noArgs "focus-workspace-down";
        "Mod+Page_Up" = noArgs "focus-workspace-up";
        "Mod+U" = noArgs "focus-workspace-down";
        "Mod+I" = noArgs "focus-workspace-up";
        "Mod+Ctrl+Down" = noArgs "move-column-to-workspace-down";
        "Mod+Ctrl+Up" = noArgs "move-column-to-workspace-up";
        "Mod+Ctrl+U" = noArgs "move-column-to-workspace-down";
        "Mod+Ctrl+I" = noArgs "move-column-to-workspace-up";

        "Mod+Shift+Page_Down" = noArgs "move-workspace-down";
        "Mod+Shift+Page_Up" = noArgs "move-workspace-up";
        "Mod+Shift+U" = noArgs "move-workspace-down";
        "Mod+Shift+I" = noArgs "move-workspace-up";

        "Mod+WheelScrollDown" = noArgs "focus-workspace-down" // { cooldown-ms = 150; };
        "Mod+WheelScrollUp" = noArgs "focus-workspace-up" // { cooldown-ms = 150; };
        "Mod+Ctrl+WheelScrollDown" = noArgs "move-column-to-workspace-down" // { cooldown-ms = 150; };
        "Mod+Ctrl+WheelScrollUp" = noArgs "move-column-to-workspace-up" // { cooldown-ms = 150; };
        "Mod+WheelScrollRight" = noArgs "focus-column-right";
        "Mod+WheelScrollLeft" = noArgs "focus-column-left";
        "Mod+Ctrl+WheelScrollRight" = noArgs "move-column-right";
        "Mod+Ctrl+WheelScrollLeft" = noArgs "move-column-left";
        "Mod+Shift+WheelScrollDown" = noArgs "focus-column-right";
        "Mod+Shift+WheelScrollUp" = noArgs "focus-column-left";
        "Mod+Ctrl+Shift+WheelScrollDown" = noArgs "move-column-right";
        "Mod+Ctrl+Shift+WheelScrollUp" = noArgs "move-column-left";

        "Mod+BracketLeft" = noArgs "consume-or-expel-window-left";
        "Mod+BracketRight" = noArgs "consume-or-expel-window-right";
        "Mod+Period" = noArgs "expel-window-from-column";
        "Mod+R" = noArgs "switch-preset-column-width";
        "Mod+Shift+R" = noArgs "switch-preset-window-height";
        "Mod+Ctrl+R" = noArgs "reset-window-height";
        "Mod+Ctrl+F" = noArgs "expand-column-to-available-width";
        "Mod+C" = noArgs "center-column";
        "Mod+Ctrl+C" = noArgs "center-visible-columns";

        "Mod+Minus" = action "set-column-width" "-10%";
        "Mod+Equal" = action "set-column-width" "+10%";
        "Mod+Shift+Minus" = action "set-window-height" "-10%";
        "Mod+Shift+Equal" = action "set-window-height" "+10%";

        "Ctrl+XF86Launch1" = noArgs "screenshot-screen";
        "Alt+XF86Launch1" = noArgs "screenshot-window";
        "Ctrl+Print" = noArgs "screenshot-screen";
        "Alt+Print" = noArgs "screenshot-window";
        "Ctrl+Alt+Print" = noArgs "screenshot";
        "Mod+Shift+P" = noArgs "power-off-monitors";
      }
      // numberedWorkspaceBinds
      // numberedWorkspaceMoveBinds;
    };
  };
}
