{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.services.trezord;
in {
  meta = {};

  imports = [];

  options = {
    services.tarsnap = {
      # already declared here:
      # https://github.com/NixOS/nixpkgs/blob/master/nixos/modules/services/backup/tarsnap.nix
      # enable = mkEnableOption "periodic tarsnap backups";
    };
  };

  # https://www.tarsnap.com/documentation.html
  config = {
    environment.systemPackages = with pkgs; [
      tarsnap
    ];

    # https://github.com/NixOS/nixpkgs/blob/master/nixos/modules/services/backup/tarsnap.nix
    services.tarsnap = {
      archives = {};
      keyfile = "";
    };
  };
}
