let
  more = { pkgs, ... }: {
    services = {
      # betterlockscreen = {
      #   enable = true;
      #   arguments = ["pixel"];
      #   inactiveInterval = 15; # in minutes
      # };

      # For the Blueman applet to work, the blueman service must be enabled system-wide. 
      blueman-applet.enable = true;

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
        inactiveInterval = 15; # in minutes
        # lockCmd = "${pkgs.betterlockscreen}/bin/betterlockscreen --lock pixel";
        lockCmd = "xflock4";
        xautolock.enable = true;
      };

      # https://nix-community.github.io/home-manager/options.html#opt-services.xidlehook.not-when-audio
      xidlehook.not-when-audio = true;
    };
  };
in
[
  more
]