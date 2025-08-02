{pkgs, ...}: let
  lockCommand = "${pkgs.lightlocker}/bin/light-locker-command --lock";
  fileManager = "${pkgs.xfce.thunar}/bin/thunar";
in {
  imports = [];

  options = {};

  config = {
    xfconf = {
      # Use the xfconf-query CLI for accessing configuration data stored in Xfconf.
      # https://docs.xfce.org/xfce/xfconf/xfconf-query
      # https://wiki.archlinux.org/title/xfce
      # https://nix-community.github.io/home-manager/options.html#opt-xfconf.settings
      settings = {
        # xfconf-query --channel xfce4-desktop --list --verbose
        "xfce4-desktop" = {
          "backdrop/screen0/monitor0/last-image" = "~/.background-image";
          # This sets the style of the wallpaper (e.g., '5' for 'scaled')
          "backdrop/screen0/monitor0/image-style" = 5;

          # I don't use workspaces, so I guess setting the wallpaper for them is not necessary.
          # "backdrop/screen0/monitor0/workspace0/last-image" = "${homeDirectory}/.background-image";
          # "backdrop/screen0/monitor0/workspace0/image-style" = 5;
          # "backdrop/screen0/monitorDP-1/workspace0/last-image" = "${homeDirectory}/.background-image";
          # "backdrop/screen0/monitorDP-1/workspace0/image-style" = 5;
        };

        # xfconf-query --channel xfce4-keyboard-shortcuts --list --verbose
        xfce4-keyboard-shortcuts = {
          # On a US keyboard layout:
          # <Primary> is the Ctrl key.
          # grave is the key with backtick/tilde
          "commands/custom/<Super>grave" = "${pkgs.rofi}/bin/rofi -show drun";
          "commands/custom/<Super>space" = "${pkgs.rofi}/bin/rofi -show drun";
          "commands/custom/<Super>d" = "${fileManager} Downloads";
          "commands/custom/<Super>h" = "${fileManager}";
          "commands/custom/<Super>k" = "xkill";
          "commands/custom/<Super>l" = lockCommand;
          "commands/custom/<Super>m" = "${fileManager} Music";
          "commands/custom/<Super>n" = "xfce4-notes";
          "commands/custom/<Super>p" = "${fileManager} Pictures";
          "commands/custom/<Super>s" = "${pkgs.flameshot}/bin/flameshot gui";
          "commands/custom/<Super>t" = "${pkgs.alacritty}/bin/alacritty";
          "commands/custom/<Super>v" = "${fileManager} Videos";
          # On XFCE this shortcut would call xflock4. I use it for other things, so I set it to null to remove it.
          "commands/default/<Primary><Alt>l" = null;
          "commands/default/Print" = "${pkgs.flameshot}/bin/flameshot gui";
        };

        # xfconf-query --channel xfce4-notifyd --list --verbose
        xfce4-notifyd = {
          "notification-log" = true;
        };

        # xfconf-query --channel xfce4-session --list --verbose
        xfce4-session = {
          "general/LockCommand" = lockCommand;
        };

        # xfconf-query --channel xsettings --list --verbose
        xsettings = {
          # "Gtk/CursorThemeName" = "";
          # "Gtk/KeyThemeName" = "";
          "Net/IconThemeName" = "Adwaita";
          "Net/ThemeName" = "Adwaita";
          # "Xfce/SyncThemes" = true;
        };
      };
    };
  };

  meta = {};
}
