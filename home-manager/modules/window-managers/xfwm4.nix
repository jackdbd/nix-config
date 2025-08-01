{...}: {
  imports = [];

  options = {};

  config = {
    xfconf = {
      # Use the xfconf-query CLI for accessing configuration data stored in Xfconf.
      # https://docs.xfce.org/xfce/xfconf/xfconf-query
      # https://wiki.archlinux.org/title/xfce
      # https://nix-community.github.io/home-manager/options.html#opt-xfconf.settings
      settings = {
        xfce4-keyboard-shortcuts = {
          "xfwm4/default/<Super>Left" = "tile_left_key";
          "xfwm4/default/<Super>KP_Left" = "tile_left_key";
          "xfwm4/default/<Super>Right" = "tile_right_key";
          "xfwm4/default/<Super>KP_Right" = "tile_right_key";
          "xfwm4/default/<Alt>F11" = "fullscreen_key";
          "xfwm4/default/<Primary><Alt>d" = "show_desktop_key";
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
      };
    };
  };

  meta = {};
}
