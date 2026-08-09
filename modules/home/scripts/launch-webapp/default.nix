{ pkgs, helium, ... }:

let
  launch-webapp = pkgs.writeShellApplication {
    name = "launch-webapp";
    runtimeInputs = with pkgs; [
      helium.packages.${pkgs.stdenv.hostPlatform.system}.helium
      util-linux
      uwsm
    ];
    text = builtins.readFile ./launch-webapp;
  };
in
{
  xdg.dataFile."systemd/user/wayland-wm-app-daemon.service".source =
    "${pkgs.uwsm}/share/systemd/user/wayland-wm-app-daemon.service";

  home.packages = [ launch-webapp ];
}
