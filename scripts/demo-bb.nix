{ pkgs, ... }:

let
  bb = "${pkgs.babashka}/bin/bb";
  bbScript = pkgs.copyPathToStore ./some-babashka-script.clj;
in
  pkgs.writeShellScriptBin "demo-bb" ''
    # Launch a Babashka script
    ${bb} -f ${bbScript}
    printf "\nScript executed by $(${bb} --version)"
  ''