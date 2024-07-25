{
  config,
  lib,
  pkgs,
  user,
  ...
}:
with lib; let
  cfg = config.services.gnome-keyring;
in {
  meta = {};

  imports = [];

  options = {
    services.gnome-keyring = {
      # enable = mkEnableOption "GNOME Keyring";
    };
  };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.seahorse # GUI for GNOME keyring (aka Passwords and Keys)
    ];

    # https://github.com/nix-community/home-manager/blob/master/modules/services/gnome-keyring.nix
    # https://nixos.wiki/wiki/Visual_Studio_Code#Error_after_Sign_On
    # https://github.com/nix-community/home-manager/issues/1454
    services.gnome-keyring = {
      components = ["pkcs11" "secrets" "ssh"];
    };
  };
}
