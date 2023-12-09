let
  more = { pkgs, ... }: {
    xfconf = {
      # Use the xfconf-query CLI for accessing configuration data stored in Xfconf.
      # https://docs.xfce.org/xfce/xfconf/xfconf-query
      # https://wiki.archlinux.org/title/xfce
      # https://nix-community.github.io/home-manager/options.html#opt-xfconf.settings
      settings = {
        # xfconf-query --channel xfce4-keyboard-shortcuts --list --verbose
        xfce4-keyboard-shortcuts = {
          # grave is the key with backtick/tilde on a US keyboard layout
          "commands/custom/<Super>grave"= "${pkgs.rofi}/bin/rofi -show drun";
          "commands/custom/<Super>space"= "${pkgs.rofi}/bin/rofi -show drun";
          "commands/custom/<Super>d"= "thunar Downloads";
          "commands/custom/<Super>h"= "thunar";
          "commands/custom/<Super>k"= "xkill";
          "commands/custom/<Super>l"= "xflock4";
          "commands/custom/<Super>m"= "thunar Music";
          "commands/custom/<Super>p"= "thunar Pictures";
          "commands/custom/<Super>s"= "${pkgs.flameshot}/bin/flameshot gui";
          "commands/custom/<Super>t"= "${pkgs.alacritty}/bin/alacritty";
          "commands/custom/<Super>v"= "thunar Videos";
          "commands/default/Print" = "${pkgs.flameshot}/bin/flameshot gui";
        };

        # xfconf-query --channel xfce4-session --list --verbose
        xfce4-session = {
            # We can lock the screen by typing `xflock4` in a terminal. 
            # https://superuser.com/questions/1696415/lock-screen-from-command-line-in-xfce
            # This would be the default command to lock the screeen. But we use betterlockscreen instead.
            # "general/LockCommand" = "${pkgs.lightdm}/bin/dm-tool lock";
            "general/LockCommand" = "${pkgs.betterlockscreen}/bin/betterlockscreen --lock";
        };

        # xfconf-query --channel xsettings --list --verbose
      };
    };
  };
in
[
  more
]