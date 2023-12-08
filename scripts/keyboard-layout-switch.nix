{ pkgs, ...}:

let
  xkbmap = "${pkgs.xorg.setxkbmap}/bin/setxkbmap";
  rg     = "${pkgs.ripgrep}/bin/rg";
in
  pkgs.writeShellScriptBin "kls" ''
    # Switch keyboard layout
    # Usage:
    # kls
    layout=$(${xkbmap} -query | ${rg} layout)

    if [[ $layout == *"us"* ]]; then
      ${xkbmap} -layout it
    else
      ${xkbmap} -layout us
    fi
  ''