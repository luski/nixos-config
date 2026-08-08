{ pkgs, ... }:

let
  to-webp = pkgs.writeShellApplication {
    name = "to-webp";
    runtimeInputs = with pkgs; [ libwebp ];
    text = builtins.readFile ./to-webp;
  };
in
{
  home.packages = [ to-webp ];
}
