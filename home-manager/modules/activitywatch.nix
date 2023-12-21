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
  meta = {};

  imports = [];

  options = {
    services.activitywatch = {
      enable = mkEnableOption "ActivityWatch";

      package = mkOption {
        type = types.package;
        default = pkgs.activitywatch;
        defaultText = literalExpression "pkgs.activitywatch";
        description = ''
          Package providing most of the ActivityWatch modules:

          - `aw-qt`
          - `aw-server` (I think it's an alias for `aw-server-rust`)
          - `aw-watcher-afk`
          - `aw-watcher-window`
        '';
      };

      extraOptions = mkOption {
        type = types.listOf types.str;
        # comma-separated list of modules to autostart (e.g. "aw-server,aw-watcher-afk,aw-watcher-window")
        # Explain whether these extraOptions override the ones defined in the TOML
        # files (e.g. aw-qt.toml, aw-watcher-afk.toml)
        default = [];
        example = [
          "--autostart-modules=aw-server,aw-watcher-afk,aw-watcher-window"
          "--testing"
          "--verbose"
        ];
        description = ''
          Extra command-line arguments to pass to {command}`aw-qt`.
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    # TODO: should I allow configuration of the ActivityWatch modules via TOML files?
    home.file = {
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

    home.packages = [cfg.package];

    # The GUI is online at http://{address}:${port} (see aw-client/aw-client.toml and aw-server-rust/config.toml)

    # https://github.com/NixOS/nixpkgs/tree/master/pkgs/applications/office/activitywatch

    # https://github.com/nix-community/home-manager/blob/e4dba0bd01956170667458be7b45f68170a63651/modules/services/syncthing.nix#L57
    # https://github.com/figsoda/cfg/blob/main/src/systemd/services/lockscreen.nix
    # https://neuron.zettel.page/install-systemd

    # TODO: Can I put an assertion like this one, but JUST for the systemd service?
    # And also another assertion that ensures that the launchd configuration applies only to macos?
    # assertions = [
    #   (lib.hm.assertions.assertPlatform "services.activitywatch" pkgs lib.platforms.linux)
    # ];

    # This creates a systemd user unit at this location:
    # ~/.config/systemd/user/activitywatch.service
    #
    # Useful commands:
    # systemctl status --user activitywatch.service
    # journalctl --user --unit=activitywatch.service --follow
    # systemctl --user daemon-reload
    # systemd-analyze security --user
    # systemd-analyze security --user activitywatch.service
    #
    # See also:
    # https://wiki.archlinux.org/title/systemd/User
    # https://github.com/nix-community/home-manager/blob/master/modules/systemd.nix
    # https://www.freedesktop.org/software/systemd/man/latest/systemd.exec.html
    systemd.user.services.activitywatch = {
      Unit = {
        Description = "ActivityWatch - Open Source Time Tracker";
        Documentation = ["https://docs.activitywatch.net/en/latest/"];
        # A few systemd user unit implemented in Home Manager (e.g.
        # blueman-applet, network-manager-applet) require "tray.target", but if
        # I do, aw-qt crashes. No idea why this occurs.
        # Requires = ["tray.target"];
        After = ["graphical-session-pre.target"];
        PartOf = ["graphical-session.target"];
      };

      Install = {WantedBy = ["graphical-session.target"];};

      Service = {
        # I have seen these Environment directives in other systemd user units,
        # but until I know what they actually do I can't just write them here.
        # Environment = with pkgs; "PATH=${makeBinPath cfg.extraPackages}";
        # Environment = "PATH=${config.home.profileDirectory}/bin";

        # TODO: improve configuration for the arguments to pass to aw-qt. Maybe
        # use something like this for ActivityWatch watchers:
        # [
        #   {id = "aw-watcher-afk"; config = {}};
        #   {id = "aw-watcher-window"; config = {}};
        # ]
        # See here for a good example of configuration.
        # https://github.com/nix-community/home-manager/blob/master/modules/services/xidlehook.nix
        ExecStart = escapeShellArgs activityWatchArgs;
        Restart = "on-failure";
        # SuccessExitStatus = [3 4];
        # RestartForceExitStatus = [3 4];

        # TODO: add some documentation about systemd service hardening, and why
        # the systemd directives used here make sense for this systemd unit.
        # https://nixos.wiki/wiki/Systemd_Hardening

        # Lock down the personality system call.
        LockPersonality = true;

        # Make it harder to change running code dynamically.
        MemoryDenyWriteExecute = true;

        # Mitigate privilege escalation.
        NoNewPrivileges = true;

        PrivateUsers = true;
        RestrictNamespaces = true;
        SystemCallArchitectures = "native";
        SystemCallFilter = "@system-service";

        Type = "simple";
      };
    };

    # TODO: Implement launchd service for MacOS (systemd is available only on Linux).
    # Have a look at the launchd service implemented for syncthing.
    # https://github.com/nix-community/home-manager/blob/e4dba0bd01956170667458be7b45f68170a63651/modules/services/syncthing.nix#L100C7-L100C14
  };
}
