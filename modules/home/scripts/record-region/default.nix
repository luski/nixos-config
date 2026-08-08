{ pkgs, ... }:

let
  record-region = pkgs.writeShellApplication {
    name = "record-region";
    runtimeInputs = with pkgs; [
      coreutils # date, mkdir
      nautilus
      slurp
      wl-screenrec
    ];
    text = builtins.readFile ./record-region;
  };
in
{
  home.packages = [ record-region ];
}
