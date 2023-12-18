{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.services.activitywatch;

  defaultActivityWatchArgs = ["${lib.getExe pkgs.aw-qt}"];

  activityWatchArgs = defaultActivityWatchArgs ++ cfg.extraOptions;
in {
  imports = [];

  options.services.activitywatch = {
    extraOptions = mkOption {
      type = types.listOf types.str;
      # comma-separated list of modules to autostart (e.g. "aw-server,aw-watcher-afk,aw-watcher-window")
      # Explain whether these extraOptions override the ones defined in the TOML
      # files (e.g. aw-qt.toml, aw-watcher-afk.toml)
      default = [];
      example = [
        "--autostart-modules=aw-server,aw-watcher-afk,aw-watcher-window"
        "--no-gui"
        "--testing"
        "--verbose"
      ];
      description = ''
        Extra command-line arguments to pass to {command}`aw-qt`.
      '';
    };
  };

  meta = {};

  config.home.file = {
    # TODO: https://github.com/jackdbd/nix-config/issues/3
    # Almost all of these TOML files are loaded by the load_config function of
    # the aw-core library, which requires these files to be named {appname}/{appname}.toml
    # https://github.com/ActivityWatch/aw-core
    # aw-server-rust is an exception. It can have 2 config files:
    # aw-server-rust/config.toml
    # aw-server-rust/config-testing.toml
    # https://github.com/ActivityWatch/aw-server-rust/blob/b87e32e84873793004d40649a21b49f024663a45/aw-sync/src/dirs.rs#L17
    "${config.xdg.configHome}/activitywatch/aw-client/aw-client.toml".source = ../../dotfiles/activitywatch/aw-client/aw-client.toml;
    "${config.xdg.configHome}/activitywatch/aw-qt/aw-qt.toml".source = ../../dotfiles/activitywatch/aw-qt/aw-qt.toml;
    "${config.xdg.configHome}/activitywatch/aw-server/aw-server.toml".source = ../../dotfiles/activitywatch/aw-server/aw-server.toml;
    "${config.xdg.configHome}/activitywatch/aw-server-rust/config.toml".source = ../../dotfiles/activitywatch/aw-server-rust/config.toml;
    "${config.xdg.configHome}/activitywatch/aw-server-rust/config-testing.toml".source = ../../dotfiles/activitywatch/aw-server-rust/config-testing.toml;
    "${config.xdg.configHome}/activitywatch/aw-watcher-afk/aw-watcher-afk.toml".source = ../../dotfiles/activitywatch/aw-watcher-afk/aw-watcher-afk.toml;
    "${config.xdg.configHome}/activitywatch/aw-watcher-window/aw-watcher-window.toml".source = ../../dotfiles/activitywatch/aw-watcher-window/aw-watcher-window.toml;
  };

  # The GUI is online at http://{address}:${port} (see aw-client/aw-client.toml and aw-server-rust/config.toml)

  # https://github.com/NixOS/nixpkgs/tree/master/pkgs/applications/office/activitywatch
  config.home.packages = [pkgs.activitywatch];

  # https://github.com/nix-community/home-manager/blob/e4dba0bd01956170667458be7b45f68170a63651/modules/services/syncthing.nix#L57
  # https://github.com/figsoda/cfg/blob/main/src/systemd/services/lockscreen.nix
  # https://neuron.zettel.page/install-systemd
  #
  # systemd service for Linux. You can check its status with:
  # systemctl status --user activitywatch.service
  # systemctl stop --user activitywatch.service
  # systemctl start --user activitywatch.service
  #
  # Reload the systemd service if you make changes:
  # systemctl daemon-reload
  config.systemd.user.services.activitywatch = {
    Unit = {
      Description = "ActivityWatch - Open Source Time Tracker";
      Documentation = "https://docs.activitywatch.net/en/latest/";
      After = ["network.target"];
    };

    Service = {
      ExecStart = escapeShellArgs activityWatchArgs;
      # Restart = "on-failure";
      # SuccessExitStatus = [3 4];
      # RestartForceExitStatus = [3 4];

      # TODO; systemd service hardening.
      # https://nixos.wiki/wiki/Systemd_Hardening
      # LockPersonality = true;
      # MemoryDenyWriteExecute = true;
      # NoNewPrivileges = true;
      # PrivateUsers = true;
      # RestrictNamespaces = true;
      # SystemCallArchitectures = "native";
      # SystemCallFilter = "@system-service";
    };

    Install = {WantedBy = ["default.target"];};
  };

  # TODO: implement launchd service for MacOS
  # https://github.com/nix-community/home-manager/blob/e4dba0bd01956170667458be7b45f68170a63651/modules/services/syncthing.nix#L100C7-L100C14
}
