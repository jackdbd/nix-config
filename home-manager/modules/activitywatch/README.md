# ActivityWatch

Configuration for [ActivityWatch](https://docs.activitywatch.net/en/latest/), an open source time tracker.

At the moment I need to manually re-import into the [ActivityWatch web UI](https://github.com/ActivityWatch/aw-webui) the [categorization rules](https://docs.activitywatch.net/en/latest/features/categorization.html) that I defined in [categorization-rules.json](./categorization-rules.json).

This Home Manager module creates a systemd user unit at this location: `~/.config/systemd/user/activitywatch.service`.

Useful commands:

```sh
systemctl status --user activitywatch.service

journalctl --user --unit=activitywatch.service --follow

systemctl --user daemon-reload

systemd-analyze security --user

systemd-analyze security --user activitywatch.service
```

See also:

- [ActivityWatch package in nixpkgs](https://github.com/NixOS/nixpkgs/tree/master/pkgs/applications/office/activitywatch)
- [Syncthing package in nixpkgs](https://github.com/nix-community/home-manager/blob/release-23.11/modules/services/syncthing.nix)
- [systemd/User](https://wiki.archlinux.org/title/systemd/User)
- [Home Manager module for systemd](https://github.com/nix-community/home-manager/blob/master/modules/systemd.nix)

**TODO**: Implement launchd service for MacOS (systemd is available only on Linux).

Have a look at the [launchd service implemented for syncthing](https://github.com/nix-community/home-manager/blob/e4dba0bd01956170667458be7b45f68170a63651/modules/services/syncthing.nix#L100C7-L100C14).
