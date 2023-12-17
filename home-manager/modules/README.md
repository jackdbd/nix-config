# home-manager modules

## activitywatch

Configuration for [ActivityWatch](https://docs.activitywatch.net/en/latest/), an open source time tracker.

At the moment I need to manually re-import into the [ActivityWatch web UI](https://github.com/ActivityWatch/aw-webui) the [categorization rules](https://docs.activitywatch.net/en/latest/features/categorization.html) that I defined in [categorization-rules.json](../../dotfiles/activitywatch/categorization-rules.json).

## lockscreen

Configuration for [betterlockscreen](https://github.com/betterlockscreen/betterlockscreen) and [xidlehook](https://github.com/jD91mZM2/xidlehook).

Pick a wallpaper for the screen locker.

```sh
betterlockscreen --update /home/jack/Pictures/wallpapers/some-wallpaper.jpg
```

## xfconf

Configuration for the [Xfconf](https://docs.xfce.org/xfce/xfconf/start), the configuration storage system used by [Xfce](https://wiki.archlinux.org/title/xfce).

Configuration data stored in Xfconf can be queried using the [xfconf-query](https://docs.xfce.org/xfce/xfconf/xfconf-query) CLI tool.

```sh
# List all configuration channels stored in Xfconf
xfconf-query -l

# List all keyboard shortcuts
xfconf-query --channel xfce4-keyboard-shortcuts --list --verbose

# List all key/value pairs of the xfwm4 (window manager) configuration
xfconf-query --channel xfwm4 --list --verbose
```
