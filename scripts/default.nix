let
  scripts = { config, lib, pkgs, ... }:
    let
      demo-bb = pkgs.callPackage ./demo-bb.nix { inherit pkgs; };
      gen-ssh-key = pkgs.callPackage ./gen-ssh-key.nix { inherit pkgs; };
      kls = pkgs.callPackage ./keyboard-layout-switch.nix { inherit pkgs; };
      szp = pkgs.callPackage ./show-zombie-parents.nix { inherit pkgs; };
    in
    {
      home.packages = [
        demo-bb
        gen-ssh-key
        kls
        szp
      ];
    };
in
[ scripts ]