let
  more = { pkgs, ... }: {
    services = {
      betterlockscreen = {
        enable = true;
        arguments = ["pixel"];
        inactiveInterval = 1; # in minutes
      };

      # For the Blueman applet to work, the blueman service must be enabled system-wide. 
      blueman-applet.enable = true;

    #   borgatic = {
    #     enable = true;
    #   };

      dunst = {
        enable = true;
        iconTheme = {
          name = "Papirus";
          package = pkgs.papirus-icon-theme;
        };
        # https://nix-community.github.io/home-manager/options.html#opt-services.dunst.settings
        settings = {
          global = {
            width = 300;
            height = 300;
            offset = "30x50";
            origin = "top-right";
            transparency = 10;
            frame_color = "#eceff1";
            font = "Droid Sans 9";
          };
          urgency_normal = {
            background = "#37474f";
            foreground = "#eceff1";
            timeout = 10;
          };
        };
      };

      flameshot = {
        enable = true;
        # https://github.com/flameshot-org/flameshot/blob/master/flameshot.example.ini
        # https://nix-community.github.io/home-manager/options.html#opt-services.flameshot.settings
        settings = {
          General = {
            uiColor = "#740096";
          };
        };
      };

      screen-locker = {
        enable = true;
        inactiveInterval = 1; # in minutes
        lockCmd = "${pkgs.betterlockscreen}/bin/betterlockscreen --lock pixel";
        # lockCmd = "xflock4";
        xautolock.enable = true;
      };

      # TODO: sxhkd doesn't seem to work as daemon. I guess it conflicts with
      # xfce4-keyboard-shortcuts. sxhkd works fine if executed in foreground though.

      # https://nix-community.github.io/home-manager/options.html#opt-services.xidlehook.not-when-audio
      xidlehook.not-when-audio = true;
    };
  };
in
[
  more
]