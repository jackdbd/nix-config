# ActivityWatch

This Home Manager module contains my configuration for [ActivityWatch](https://docs.activitywatch.net/en/latest/), an open source time tracker.

This module also defines a systemd service that executes [aw-qt](https://github.com/ActivityWatch/aw-qt) when the user logs in, and a systemd timer that periodically cleans up the logs generated by ActivityWatch modules (aw-qt, aw-server-rust, aw watchers).

> :information_source: The [ActivityWatch web UI](https://github.com/ActivityWatch/aw-webui) allows to define [categorization rules](https://docs.activitywatch.net/en/latest/features/categorization.html) for the apps we are using, (or the websites we are visiting). As far as I know, these rules cannot be configured in a programmatic way, and must be re-imported in the web UI each time we want to change them. I keep my updated list of rules in this JSON file: [categorization-rules.json](./categorization-rules.json).

## Configuration

This Home Manager module allows to configure these ActivityWatch packages:

- aw-qt
- aw-server-rust
- aw-client
- aw-watcher-afk
- aw-watcher-window

Here is an example:

```nix
services.activitywatch = {
  enable = true;
  client = {
    client = {
      commit_interval = 15;
    };
  };
  qt = {
    aw-qt = {
      autostart_modules = [
        "aw-server"
        "aw-watcher-afk"
        "aw-watcher-window"
      ];
    };
  };
};
```

## activitywatch.service

Here are some useful commands to manage the `activitywatch.service` systemd service.

Check the status of the service:

```sh
systemctl status --user activitywatch.service
```

Follow new messages logged by the service:

```sh
journalctl --user --unit=activitywatch.service --follow
```

Check the security score of the service (see also [systemd hardening](https://nixos.wiki/wiki/Systemd_Hardening)):

```sh
systemd-analyze security --user activitywatch.service
```

## activitywatch-cleanup-logs.timer and activitywatch-cleanup-logs.service

Check the status of the timer and that it triggers `activitywatch-cleanup-logs.service`:

```sh
systemctl status --user activitywatch-cleanup-logs.timer
```

## Reference

- [ActivityWatch package in nixpkgs](https://github.com/NixOS/nixpkgs/tree/master/pkgs/applications/office/activitywatch)
- [Syncthing package in nixpkgs](https://github.com/nix-community/home-manager/blob/release-23.11/modules/services/syncthing.nix)
- [systemd/User](https://wiki.archlinux.org/title/systemd/User)
- [Home Manager module for systemd](https://github.com/nix-community/home-manager/blob/master/modules/systemd.nix)

## TODOs

Implement launchd service for MacOS (systemd is available only on Linux). Have a look at the [launchd service implemented for syncthing](https://github.com/nix-community/home-manager/blob/e4dba0bd01956170667458be7b45f68170a63651/modules/services/syncthing.nix#L100C7-L100C14).

Troubleshoot why aw-qt cannot create the system tray and crashes the first time, but then it immediately restarts and keeps running with no issues. See also [qt.qpa.plugin: Could not load the Qt platform plugin "xcb" in "" even though it was found](https://github.com/ActivityWatch/activitywatch/issues/960).
