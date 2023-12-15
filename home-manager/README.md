# home-manager

I use [Home Manager](https://nixos.wiki/wiki/Home_Manager) to manage my users' environment (i.e. installing packages in a user's profile and manage dotfiles).

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

## Reference

- [Home Manager configuration options](https://nix-community.github.io/home-manager/options.html)
- [gvolpe's Home Manager config](https://github.com/gvolpe/nix-config/tree/master/home)
- [Misterio77 standard Home Manager config](https://github.com/Misterio77/nix-starter-configs/tree/main/standard/home-manager)
