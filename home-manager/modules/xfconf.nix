{pkgs, ...}: {
  imports = [];

  options = {};

  config = {
    xfconf = {
      # Use the xfconf-query CLI for accessing configuration data stored in Xfconf.
      # https://docs.xfce.org/xfce/xfconf/xfconf-query
      # https://wiki.archlinux.org/title/xfce
      # https://nix-community.github.io/home-manager/options.html#opt-xfconf.settings
      settings = {
        # xfconf-query --channel xfce4-keyboard-shortcuts --list --verbose
        xfce4-keyboard-shortcuts = {
          # On a US keyboard layout:
          # <Primary> is the Ctrl key.
          # grave is the key with backtick/tilde
          "commands/custom/<Super>grave" = "${pkgs.rofi}/bin/rofi -show drun";
          "commands/custom/<Super>space" = "${pkgs.rofi}/bin/rofi -show drun";
          "commands/custom/<Super>d" = "thunar Downloads";
          "commands/custom/<Super>h" = "thunar";
          "commands/custom/<Super>k" = "xkill";
          "commands/custom/<Super>l" = "xflock4";
          "commands/custom/<Super>m" = "thunar Music";
          "commands/custom/<Super>n" = "xfce4-notes";
          "commands/custom/<Super>p" = "thunar Pictures";
          "commands/custom/<Super>s" = "${pkgs.flameshot}/bin/flameshot gui";
          "commands/custom/<Super>t" = "${pkgs.alacritty}/bin/alacritty";
          "commands/custom/<Super>v" = "thunar Videos";
          "commands/default/Print" = "${pkgs.flameshot}/bin/flameshot gui";
          "xfwm4/custom/<Super>Left" = "tile_left_key";
          "xfwm4/custom/<Super>Right" = "tile_right_key";
          "xfwm4/default/<Alt>F11" = "fullscreen_key";
          "xfwm4/default/<Primary><Alt>d" = "show_desktop_key";
        };

        # xfconf-query --channel xfce4-notifyd --list --verbose
        xfce4-notifyd = {
          "notification-log" = true;
        };

        # xfconf-query --channel xfce4-session --list --verbose
        xfce4-session = {
          # We can lock the screen by typing `xflock4` in a terminal.
          # https://superuser.com/questions/1696415/lock-screen-from-command-line-in-xfce
          # This would be the default command to lock the screeen. But we use betterlockscreen instead.
          # "general/LockCommand" = "${pkgs.lightdm}/bin/dm-tool lock";
          "general/LockCommand" = "${pkgs.betterlockscreen}/bin/betterlockscreen --lock";
        };

        # xfconf-query --channel xfwm4 --list --verbose
        xfwm4 = {
          # TODO: how do I change theme?
          # https://www.xfce-look.org/browse?cat=138&ord=latest
          # https://www.xfce-look.org/browse?cat=135
          # https://github.com/NixOS/nixpkgs/blob/nixos-23.11/pkgs/desktops/xfce/art/xfwm4-themes/default.nix#L18
          # "general/theme" = "plano";
          # "general/theme" = "tux";
          "general/theme" = "Default";
          "general/title_font" = "Sans Bold 9";
          "general/use_compositing" = true;
        };

        # xfconf-query --channel xsettings --list --verbose
      };
    };
  };

  meta = {};
}
