{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.services.activitywatch;

  defaultActivityWatchArgs = [
    "${pkgs.aw-qt}/bin/aw-qt"
    # "--verbose"
    # "--autostart-modules"
    # comma-separated list of modules to autostart (e.g. "aw-server,aw-watcher-afk,aw-watcher-window")
  ];

  activityWatchArgs = defaultActivityWatchArgs ++ cfg.extraOptions;
in {
  imports = [];

  options.services.activitywatch = {
    extraOptions = mkOption {
      type = types.listOf types.str;
      default = [];
      example = ["--autostart-modules=aw-server,aw-watcher-afk,aw-watcher-window" "--no-gui"];
      description = ''
        Extra command-line arguments to pass to {command}`aw-qt`.
      '';
    };
  };

  meta = {};

  config.home = {
    file = {
      # TODO: https://github.com/jackdbd/nix-config/issues/3
      "${config.xdg.configHome}/activitywatch/aw-client/aw-client.toml".source = ../../dotfiles/activitywatch/aw-client/aw-client.toml;
      "${config.xdg.configHome}/activitywatch/aw-qt/aw-qt.toml".source = ../../dotfiles/activitywatch/aw-qt/aw-qt.toml;
      "${config.xdg.configHome}/activitywatch/aw-server/aw-server.toml".source = ../../dotfiles/activitywatch/aw-server/aw-server.toml;
      "${config.xdg.configHome}/activitywatch/aw-server-rust/config.toml".source = ../../dotfiles/activitywatch/aw-server-rust/config.toml;
      "${config.xdg.configHome}/activitywatch/aw-watcher-afk/aw-watcher-afk.toml".source = ../../dotfiles/activitywatch/aw-watcher-afk/aw-watcher-afk.toml;
      "${config.xdg.configHome}/activitywatch/aw-watcher-window/aw-watcher-window.toml".source = ../../dotfiles/activitywatch/aw-watcher-window/aw-watcher-window.toml;
    };

    packages = [
      # https://github.com/NixOS/nixpkgs/tree/master/pkgs/applications/office/activitywatch
      pkgs.activitywatch # time tracker
    ];
  };

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
  #
  # The GUI is online at http://127.0.0.1:5600/
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

  # TODO: launchd service for MacOS
  # https://github.com/nix-community/home-manager/blob/e4dba0bd01956170667458be7b45f68170a63651/modules/services/syncthing.nix#L100C7-L100C14

  # TODO: systemd service for the system tray on Linux
}
