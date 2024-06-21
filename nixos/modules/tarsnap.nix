{
  config,
  lib,
  pkgs,
  user,
  ...
}:
with lib; let
  cfg = config.services.tarsnap;
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

    # Visit https://www.tarsnap.com/account.html to manage your Tarsnap account

    # List all Tarsnap archives available on this machine
    # tarsnap --list-archives --keyfile "$HOME/tarsnap.key" | sort

    # Restore a Tarsnap archive available on this machine
    # tarsnap -x -f mycomputer-2015-08-09_19-37-20 --keyfile "$HOME/tarsnap.key"

    # https://github.com/NixOS/nixpkgs/blob/master/nixos/modules/services/backup/tarsnap.nix
    services.tarsnap = {
      # This creates the systemd system timer tarsnap-docs.timer, which will
      # trigger the systemd system service tarsnap-docs.service
      # You can list all systemd system timers with this command:
      # systemctl --system list-timers
      archives.docs = {
        cachedir = "/home/${user}/tarsnap-cache";
        directories = [
          "/home/${user}/Documents/shared-documents"
        ];
        excludes = [];
        nodump = true;
        # The time format for `period` is described in `man systemd.time`. Examples: "*:30", "01:15", "hourly", "daily"
        period = "hourly";
        printStats = true;
        verbose = true;
      };

      archives.music = {
        directories = [
          "/home/${user}/Music/shared-music/random-mix"
        ];
        period = "daily";
      };

      keyfile = "/home/${user}/tarsnap.key";
    };
  };
}
