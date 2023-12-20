{
  config,
  lib,
  pkgs,
  user,
  ...
}:
with lib; let
  cfg = config.services.activitywatch;

  defaultUser = "activitywatch";
  defaultGroup = defaultUser;
  defaultActivityWatchArgs = ["${lib.getExe pkgs.aw-qt}"];

  activityWatchArgs = defaultActivityWatchArgs ++ cfg.extraOptions;
in {
  imports = [];

  meta = {};

  # https://github.com/nix-community/home-manager/blob/e4dba0bd01956170667458be7b45f68170a63651/modules/services/syncthing.nix#L57
  options = {
    services.activitywatch = {
      enable = mkEnableOption "ActivityWatch time tracker";

      user = mkOption {
        type = types.str;
        default = defaultUser;
        example = "yourUser";
        description = mdDoc ''
          The user to run ActivityWatch as.
          By default, a user named `${defaultUser}` will be created.
        '';
      };

      group = mkOption {
        type = types.str;
        default = defaultGroup;
        example = "yourGroup";
        description = mdDoc ''
          The group to run ActivityWatch under.
          By default, a group named `${defaultGroup}` will be created.
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
          "--no-gui"
          "--testing"
          "--verbose"
        ];
        description = ''
          Extra command-line arguments to pass to {command}`aw-qt`.
        '';
      };
    };
  };

  # The GUI is online at http://{address}:${port} (see aw-client/aw-client.toml and aw-server-rust/config.toml)

  # https://github.com/figsoda/cfg/blob/main/src/systemd/services/lockscreen.nix
  # https://neuron.zettel.page/install-systemd
  #
  # systemd service for Linux. You can check its status with (add --user if you are using it as a Home Manager module):
  # systemctl status activitywatch.service
  # systemctl stop activitywatch.service
  # systemctl start --user activitywatch.service
  #
  # security audit
  # systemd-analyze security
  # systemd-analyze security activitywatch.service
  #
  # Reload the systemd service if you make changes:
  # sudo systemctl daemon-reload

  # journalctl -u activitywatch --follow

  # systemctl show -pUser,UID activitywatch.service

  config = mkIf cfg.enable {
    # home.file = {
    #   # TODO: https://github.com/jackdbd/nix-config/issues/3
    #   # Almost all of these TOML files are loaded by the load_config function of
    #   # the aw-core library, which requires these files to be named {appname}/{appname}.toml
    #   # https://github.com/ActivityWatch/aw-core
    #   # aw-server-rust is an exception. It can have 2 config files:
    #   # aw-server-rust/config.toml
    #   # aw-server-rust/config-testing.toml
    #   # https://github.com/ActivityWatch/aw-server-rust/blob/b87e32e84873793004d40649a21b49f024663a45/aw-sync/src/dirs.rs#L17
    #   "${config.xdg.configHome}/activitywatch/aw-client/aw-client.toml".source = ../../dotfiles/activitywatch/aw-client/aw-client.toml;
    #   "${config.xdg.configHome}/activitywatch/aw-qt/aw-qt.toml".source = ../../dotfiles/activitywatch/aw-qt/aw-qt.toml;
    #   "${config.xdg.configHome}/activitywatch/aw-server/aw-server.toml".source = ../../dotfiles/activitywatch/aw-server/aw-server.toml;
    #   "${config.xdg.configHome}/activitywatch/aw-server-rust/config.toml".source = ../../dotfiles/activitywatch/aw-server-rust/config.toml;
    #   "${config.xdg.configHome}/activitywatch/aw-server-rust/config-testing.toml".source = ../../dotfiles/activitywatch/aw-server-rust/config-testing.toml;
    #   "${config.xdg.configHome}/activitywatch/aw-watcher-afk/aw-watcher-afk.toml".source = ../../dotfiles/activitywatch/aw-watcher-afk/aw-watcher-afk.toml;
    #   "${config.xdg.configHome}/activitywatch/aw-watcher-window/aw-watcher-window.toml".source = ../../dotfiles/activitywatch/aw-watcher-window/aw-watcher-window.toml;
    # };

    # users.groups.activitywatch = {};

    # https://nixpkgs-manual-sphinx-markedown-example.netlify.app/configuration/user-mgmt.xml
    # https://github.com/NixOS/nixpkgs/blob/69973a9a20858b467dd936542c63554f3675e02d/nixos/modules/services/networking/syncthing.nix#L623
    # users.users = {
    #   ${cfg.user} = {
    #     description = "ActivityWatch daemon user";
    #     isSystemUser = true;
    #     group = cfg.group;
    #     # createHome = true;
    #     # extraGroups = [];
    #     # The user ID (uid) is assigned automatically, but in some cases it's
    #     # better to assign it manually. There is global list of uids and guids.
    #     # https://github.com/NixOS/nixpkgs/blob/23.11/nixos/modules/misc/ids.nix
    #   };
    # };
    environment.sessionVariables = {
      QT_DEBUG_PLUGINS = "1"; # this could be useful for troubleshooting
      # https://github.com/NVlabs/instant-ngp/discussions/300
    };

    environment.systemPackages = [pkgs.activitywatch];

    # https://github.com/NixOS/nixpkgs/tree/master/pkgs/applications/office/activitywatch
    # home.packages = [pkgs.activitywatch];
    systemd.packages = [pkgs.activitywatch];

    # https://nixos.wiki/wiki/Extend_NixOS
    # https://github.com/NixOS/nixpkgs/tree/23.11/nixos/modules/services
    systemd.services = {
      # TODO: when aw-qt is launched as a systemd service, it fails with this error:
      # qt.qpa.plugin: Could not find the Qt platform plugin "xcb" in ""
      # It's explained here:
      # https://nixos.wiki/wiki/Qt#qt.qpa.plugin:_Could_not_find_the_Qt_platform_plugin_.22xcb.22_in_.22.22
      activitywatch = {
        description = "ActivityWatch - Open Source Time Tracker";
        documentation = ["https://docs.activitywatch.net/en/latest/"];

        wantedBy = ["multi-user.target"];
        after = ["network.target"];

        environment = {
          DISPLAY = ":1";
          QT_DEBUG_PLUGINS = "1";
        };

        serviceConfig = {
          ExecStart = escapeShellArgs activityWatchArgs;
          Restart = "on-failure";

          # https://www.freedesktop.org/software/systemd/man/latest/systemd.exec.html#User=
          # https://docs.arbitrary.ch/security/systemd.html#user
          # User = cfg.user;
          # User = user;
          # Group = cfg.group;

          # https://nixos.wiki/wiki/Systemd_Hardening

          # Lock down the personality system call.
          # https://www.freedesktop.org/software/systemd/man/latest/systemd.exec.html#Personality=
          LockPersonality = true;

          # Make it harder to change running code dynamically.
          # https://www.freedesktop.org/software/systemd/man/latest/systemd.exec.html#MemoryDenyWriteExecute=
          # MemoryDenyWriteExecute = true;

          # Mitigate privilege escalation.
          # https://www.freedesktop.org/software/systemd/man/latest/systemd.exec.html#NoNewPrivileges=
          NoNewPrivileges = true;

          # Set up a new /dev mount for the executed processes and only add API
          # pseudo devices such as /dev/null, /dev/zero or /dev/random to it, but no
          # physical devices such as /dev/sda, system memory /dev/mem, system ports
          # /dev/port and others.
          PrivateDevices = true;

          # Mount private /tmp/ and /var/tmp/ directories that can be used only by
          # this service.
          # https://www.freedesktop.org/software/systemd/man/latest/systemd.exec.html#PrivateTmp=
          # PrivateTmp = true;

          # https://www.freedesktop.org/software/systemd/man/latest/systemd.exec.html#PrivateUsers=
          PrivateUsers = true;

          # https://www.freedesktop.org/software/systemd/man/latest/systemd.exec.html#ProtectKernelModules=
          ProtectKernelModules = true;

          # I don't think setting ProtectSystem to "strict" makes any difference on
          # NixOS, but it should on other Linux distros.
          # https://www.freedesktop.org/software/systemd/man/latest/systemd.exec.html#ProtectSystem=
          # ProtectSystem = "strict";

          # RestrictNamespaces = true;

          # Disable system calls that make use of non-native ABIs.
          # https://www.freedesktop.org/software/systemd/man/latest/systemd.exec.html#SystemCallArchitectures=
          SystemCallArchitectures = "native";

          # Define an allow list for syscalls.
          SystemCallFilter = "@system-service";

          Type = "simple";
        };
      };
    };
  };

  # TODO: implement launchd service for MacOS
  # https://github.com/nix-community/home-manager/blob/e4dba0bd01956170667458be7b45f68170a63651/modules/services/syncthing.nix#L100C7-L100C14
}
