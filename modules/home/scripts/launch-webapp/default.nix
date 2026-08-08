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
  home.packages = [ launch-webapp ];
}
