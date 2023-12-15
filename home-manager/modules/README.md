# home-manager modules

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
