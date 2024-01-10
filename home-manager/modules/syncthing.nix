{
  config,
  lib,
  pkgs,
  user,
  ...
}:
with lib; let
  cfg = config.services.syncthing;
in {
  meta = {};

  imports = [];

  options = {};

  config = {
    home.packages = [pkgs.syncthing];

    # https://mipmip.github.io/home-manager-option-search/?query=syncthing
    # syncthing serve --help
    services.syncthing = {
      enable = true;
      extraOptions = [
        "--gui-address=127.0.0.1:8384"
        "--no-default-folder"
      ];
      # https://github.com/nix-community/home-manager/blob/e13aa9e287b3365473e5897e3667ea80a899cdfb/modules/services/syncthing.nix#L34
      # https://github.com/Martchus/syncthingtray
      tray = {
        enable = false;
      };
    };
  };
}
