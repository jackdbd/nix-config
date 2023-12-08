let
  more = { pkgs, ... }: {
    services = {
      betterlockscreen = {
        enable = true;
        # https://nix-community.github.io/home-manager/options.html#opt-services.betterlockscreen.arguments
        arguments = ["blur"];
        # https://github.com/betterlockscreen/betterlockscreen/blob/next/examples/betterlockscreenrc
        inactiveInterval = 15; # in minutes
      };

    #   borgatic = {
    #     enable = true;
    #   };

    #   dunst = {
    #     enable = true;
    #   };

      flameshot = {
        enable = true;
      };

      screen-locker = {
        enable = true;
        # https://nix-community.github.io/home-manager/options.html#opt-services.screen-locker.inactiveInterval
        inactiveInterval = 15; # in minutes
        # lockCmd = "${pkgs.betterlockscreen}/bin/betterlockscreen --lock blur";
      };

      # TODO: sxhkd doesn't seem to work as daemon. I guess it conflicts with xfce4-keyboard-shortcuts.
      # sxhkd works fine if executed in foreground though.
      sxhkd = {
        enable = true;
        # https://nix-community.github.io/home-manager/options.html#opt-services.sxhkd.keybindings
        # https://github.com/baskerville/sxhkd
        # https://wiki.archlinux.org/title/Sxhkd
        keybindings = {
        "super + k" = "${pkgs.rofi}/bin/rofi";
        "super + l" = "${pkgs.betterlockscreen}/bin/betterlockscreen --lock";
        "super + F1" = pkgs.writeShellScript "script" "echo $USER";
        };
      };
    };
  };
in
[
  more
]