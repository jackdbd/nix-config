{
  config,
  lib,
  pkgs,
  user,
  ...
}: {
  imports = [];

  options = {};

  config = {
    # peer-to-peer file synchronization
    # https://nixos.wiki/wiki/Syncthing
    services.syncthing = {
      inherit user;

      enable = true;
      configDir = "/home/${user}/.config/syncthing"; # Folder for Syncthing's settings and keys
      dataDir = "/home/${user}/Documents"; # Default folder for new synced folders
      guiAddress = "0.0.0.0:8384";
      # user = user;
    };
  };

  meta = {};
}
