{
  config,
  lib,
  pkgs,
  user,
  ...
}:
with lib; let
  cfg = config.programs.syncthing-wrapper;
in {
  imports = [];

  # https://search.nixos.org/options?channel=23.11&from=0&size=50&sort=relevance&type=packages&query=syncthing
  options.programs.syncthing-wrapper = {
    guiAddress = mkOption {
      type = types.str;
      description = mdDoc ''
        The address of the Syncthing graphical user interface.
      '';
      default = "0.0.0.0:8384";
      example = "127.0.0.1:8384";
    };
  };

  config = {
    environment.systemPackages = with pkgs; [
      syncthing # peer-to-peer file synchronization
    ];

    services.syncthing = {
      inherit user;

      enable = true;
      configDir = "/home/${user}/.config/syncthing"; # Folder for Syncthing's settings and keys
      dataDir = "/home/${user}/Documents"; # Default folder for new synced folders
      guiAddress = cfg.guiAddress;
    };
  };

  meta = {};
}
