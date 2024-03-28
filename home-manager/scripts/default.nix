let
  scripts = {
    config,
    lib,
    pkgs,
    ...
  }: let
    gen-ssh-key = pkgs.callPackage ./gen-ssh-key.nix {inherit pkgs;};
    install-zigup = pkgs.callPackage ./install-zigup.nix {inherit pkgs;};
    kls = pkgs.callPackage ./keyboard-layout-switch.nix {inherit pkgs;};
    szp = pkgs.callPackage ./show-zombie-parents.nix {inherit pkgs;};
  in {
    home.packages = [
      gen-ssh-key
      install-zigup
      kls
      szp
    ];
  };
in [scripts]
