{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.services.activitywatch;

  tomlFormat = pkgs.formats.toml {};

  # attrs util that removes entries containing a null value
  compactAttrs = lib.filterAttrs (_: val: !isNull val);

  defaultServerHostname = "127.0.0.1";
  defaultServerHostnameTesting = "127.0.0.1";
  defaultServerPort = 5600;
  defaultServerPortTesting = 5666;

  defaultServerConfig = {
    address = defaultServerHostname;
    port = defaultServerPort;
    cors = [];
    # aw-server-rust does not support the experimental custom_static feature (see aw-server PR #83).
    # https://github.com/ActivityWatch/aw-server/pull/83
    # "custom_static" = {};
  };

  defaultServerConfigTesting = {
    address = defaultServerHostnameTesting;
    port = defaultServerPortTesting;
    cors = [];
  };

  defaultClientConfig = {
    client = {
      # How often to commit events to the server (in seconds).
      commit_interval = 10;
    };
    "client-testing" = {
      commit_interval = 5;
    };
    server = {
      hostname = defaultServerHostname;
      port = defaultServerPort;
    };
    "server-testing" = {
      hostname = defaultServerHostnameTesting;
      port = defaultServerPortTesting;
    };
  };

  defaultWatcherAfkConfig = {
    "aw-watcher-afk" = {
      # Time in seconds after which a period without keyboard or mouse activity
      # is considered to be AFK (away from keyboard).
      timeout = 180;
      # Time in seconds between checks for activity.
      poll_time = 5;
    };
    "aw-watcher-afk-testing" = {
      timeout = 20;
      poll_time = 1;
    };
  };

  defaultWatcherWindowConfig = {
    "aw-watcher-window" = {
      # Don’t track window titles
      exclude_title = false;
      # Time in seconds between window checks.
      poll_time = 1.0;
      # The strategy to use on macOS to fetch the active window, can be "swift",
      # "jxa" or "applescript". Swift strategy is preferred.
      strategy_macos = "swift";
    };
  };

  defaultQtConfig = {
    # should I call bin/aw-server or bin/.aw-server-wrapped (i.e. the Qt library wrapped in the aw-server binary I think)
    "aw-qt" = {
      autostart_modules = [
        "aw-server"
        "aw-watcher-afk"
        "aw-watcher-window"
      ];
    };
    "aw-qt-testing" = {
      autostart_modules = [
        "${pkgs.aw-server-rust}/bin/aw-server" # there is no pkgs.aw-server
        "${pkgs.aw-server-rust}/bin/.aw-server-wrapped" # there is no pkgs.aw-server
        "${pkgs.aw-watcher-afk}/bin/aw-watcher-afk"
        "${pkgs.aw-watcher-window}/bin/aw-watcher-window"
        # just to check the filepath
        "${pkgs.aw-qt}/bin/.aw-qt-wrapped"
        "${pkgs.aw-qt}/bin/aw-qt"
      ];
      verbose = true;
    };
  };
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
          - `aw-server-rust`
          - `aw-watcher-afk`
          - `aw-watcher-window`
        '';
      };

      client = mkOption {
        type = tomlFormat.type;
        default = defaultClientConfig;
        example = literalExpression ''
          client = {
            commit_interval = 10;
          };
          "client-testing" = {
            commit_interval = 5;
          };
          server = {
            hostname = "127.0.0.1";
            port = 5600;
          };
          "server-testing" = {
            hostname = "127.0.0.1";
            port = 5666;
          };
        '';
        description = ''
          Configuration for the ActivityWatch client.

          It will generate {file}`$XDG_CONFIG_HOME/activitywatch/aw-client/aw-client.toml`.

          See <https://docs.activitywatch.net/en/latest/configuration.html#aw-client>
          for details on the configuration parameters.
        '';
      };

      server-rust = mkOption {
        type = tomlFormat.type;
        default = defaultServerConfig;
        example = literalExpression ''
          address = "127.0.0.1";
          port = 5600;
        '';
        description = ''
          Configuration for the ActivityWatch server.

          It will generate {file}`$XDG_CONFIG_HOME/activitywatch/aw-server-rust/config.toml`.

          See <https://docs.activitywatch.net/en/latest/configuration.html#aw-server-rust>
          for details on the configuration parameters.
        '';
      };

      server-rust-testing = mkOption {
        type = tomlFormat.type;
        default = defaultServerConfigTesting;
        example = literalExpression ''
          address = "127.0.0.1";
          port = 5666;
        '';
        description = ''
          Configuration for the ActivityWatch server (testing).

          It will generate {file}`$XDG_CONFIG_HOME/activitywatch/aw-server-rust/config-testing.toml`.

          See <https://docs.activitywatch.net/en/latest/configuration.html#aw-server-rust>
          for details on the configuration parameters.
        '';
      };

      qt = mkOption {
        type = tomlFormat.type;
        default = defaultQtConfig;
        example = literalExpression ''
          aw-qt = {
            autostart_modules = ["aw-server" "aw-watcher-afk" "aw-watcher-window"];
          };
          aw-qt-testing = {
            autostart_modules = ["aw-server" "aw-watcher-afk" "aw-watcher-window"];
            verbose = true;
          };
        '';
        description = ''
          Configuration for aw-qt (application that starts ActivityWatch and creates a tray icon).

          It will generate {file}`$XDG_CONFIG_HOME/activitywatch/aw-qt/aw-qt.toml`.
        '';
      };

      # Maybe an option like this one would be better?
      # watchers = [
      #   {id = "afk"; config={}};
      #   {id = "window"; config={}};
      # ]

      watcher-afk = mkOption {
        type = tomlFormat.type;
        default = defaultWatcherAfkConfig;
        example = literalExpression ''
          aw-watcher-afk = {
            timeout = 180;
            poll_time = 5;
          };
          aw-watcher-afk-testing = {
            timeout = 20;
            poll_time = 1;
            verbose = true;
          };
        '';
        description = ''
          Configuration for aw-watcher-afk.

          See <https://docs.activitywatch.net/en/latest/configuration.html#aw-watcher-afk>
          for details.
        '';
      };

      watcher-window = mkOption {
        type = tomlFormat.type;
        default = defaultWatcherWindowConfig;
        example = literalExpression ''
          aw-watcher-window = {
            exclude_title = false;
            poll_time = 1.0;
          };
        '';
        description = ''
          Configuration for aw-watcher-window.

          See <https://docs.activitywatch.net/en/latest/configuration.html#aw-watcher-window>
          for details.
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    # Should I allow configuration of the ActivityWatch modules via TOML files?
    home.file = {
      # Almost all of these TOML files are loaded by the load_config function of
      # the aw-core library, which requires these files to be named {appname}/{appname}.toml
      # https://github.com/ActivityWatch/aw-core
      # aw-server-rust is an exception. It can have 2 config files:
      # aw-server-rust/config.toml
      # aw-server-rust/config-testing.toml
      # https://github.com/ActivityWatch/aw-server-rust/blob/b87e32e84873793004d40649a21b49f024663a45/aw-sync/src/dirs.rs#L17
      # "${config.xdg.configHome}/activitywatch/aw-qt/aw-qt.toml".source = ../../dotfiles/activitywatch/aw-qt/aw-qt.toml;
    };

    home.packages = [cfg.package];

    # Recursively merge the provided config into the default one.

    xdg.configFile."activitywatch/aw-client/aw-client.toml".source = let
      userConfig = compactAttrs cfg.client;
      mergedConfig = lib.recursiveUpdate defaultClientConfig userConfig;
    in
      tomlFormat.generate "aw-client/aw-client.toml" mergedConfig;

    xdg.configFile."activitywatch/aw-server-rust/config.toml".source = let
      userConfig = compactAttrs cfg.server-rust;
      mergedConfig = lib.recursiveUpdate defaultServerConfig userConfig;
    in
      tomlFormat.generate "aw-server-rust/config.toml" mergedConfig;

    xdg.configFile."activitywatch/aw-server-rust/config-testing.toml".source = let
      userConfig = compactAttrs cfg.server-rust-testing;
      mergedConfig = lib.recursiveUpdate defaultServerConfigTesting userConfig;
    in
      tomlFormat.generate "aw-server-rust/config-testing.toml" mergedConfig;

    xdg.configFile."activitywatch/aw-watcher-afk/aw-watcher-afk.toml".source = let
      userConfig = compactAttrs cfg.watcher-afk;
      mergedConfig = lib.recursiveUpdate defaultWatcherAfkConfig userConfig;
    in
      tomlFormat.generate "aw-watcher-afk/aw-watcher-afk.toml" mergedConfig;

    xdg.configFile."activitywatch/aw-watcher-window/aw-watcher-window.toml".source = let
      userConfig = compactAttrs cfg.watcher-window;
      mergedConfig = lib.recursiveUpdate defaultWatcherWindowConfig userConfig;
    in
      tomlFormat.generate "aw-watcher-window/aw-watcher-window.toml" mergedConfig;

    xdg.configFile."activitywatch/aw-qt/aw-qt.toml".source = let
      userConfig = compactAttrs cfg.qt;
      mergedConfig = lib.recursiveUpdate defaultQtConfig userConfig;
    in
      tomlFormat.generate "aw-qt/aw-qt.toml" mergedConfig;

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

        # See here for a good example of configuration.
        # https://github.com/nix-community/home-manager/blob/master/modules/services/xidlehook.nix
        ExecStart = escapeShellArgs ["${pkgs.aw-qt}/bin/aw-qt"];
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
