{
  lib,
  pkgs,
  ...
}: {
  meta = {};

  imports = [];

  options = {};

  config.home.packages = [];

  # https://www.reddit.com/r/hyprland/comments/195g044/how_to_properly_make_the_screen_lock_suspend/
  config.programs.hyprlock = {
    enable = true;
  };

  config.services.hypridle = {
    enable = true;
    # Configuration for hypridle
    # https://wiki.hypr.land/Hypr-Ecosystem/hypridle/
    settings = {
      general = {
        lock_cmd = "hyprlock";
      };

      listener = [
        # {
        #   timeout = 150;
        #   on-timeout = "brightnessctl -sd rgb:kbd_backlight set 0"; # turn off keyboard backlight
        #   on-resume = "brightnessctl -rd rgb:kbd_backlight"; # turn on keyboard backlight
        # }
        {
          timeout = 300;
          on-timeout = "hyprlock";
        }
      ];
    };
  };

  # https://wiki.hyprland.org/Nix/Hyprland-on-Home-Manager/
  # https://nixos.wiki/wiki/Hyprland#Configuration
  # https://home-manager-options.extranix.com/?query=wayland.windowManager
  # https://github.com/FlafyDev/nixos-config/blob/61ea9fea72db1cb449e7c0266cd28aac7c23d9af/modules/display/hyprland/default.nix

  # vimjoyer videos about Hyprland configuration
  # https://youtu.be/61wGzIv12Ds?si=aRxa2tHfh_uMaUbM&t=282
  # https://youtu.be/zt3hgSBs11g?si=WR_Zwbxt3cmdh0cO
  config.wayland.windowManager.hyprland = {
    enable = true;

    # Extra configuration lines to add to `~/.config/hypr/hyprland.conf`.
    # https://github.com/nix-community/home-manager/blob/1c43dcfac48a2d622797f7ab741670fdbcf8f609/modules/services/window-managers/hyprland.nix#L159
    extraConfig = ''
    '';

    plugins = [
      # https://youtu.be/zt3hgSBs11g?si=nwcKtZmX8XgBz-Bd&t=199
      # inputs.hyprland-plugins.packages."${pkgs.system}".borders-plus-plus
    ];

    settings = {
      # https://wiki.hyprland.org/Configuring/Animations/
      animations = {
        enabled = "no";
      };

      # https://wiki.hyprland.org/Configuring/Binds/
      bind = [
        "ALT, F4, killactive"
        "$mainMod, A, exec, rofi -show drun -show-icons"
        "$mainMod, C, killactive"
        # "$mainMod, E, exec $fileManager"
        "$mainMod, L, exec, hyprlock"
        "$mainMod, M, exit"

        "$mainMod, T, exec, $terminal"
        # "$mainMod, S, exec, rofi -show drun -show-icons"
        # grave is the key with backtick/tilde
        # "$mainMod, grave, exec, rofi -show drun -show-icons"

        # Move focus with mainMod + arrow keys
        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up, movefocus, u"
        "$mainMod, down, movefocus, d"

        "$mod, escape, exec, rofi -show drun -show-icons"
        "$mod, Q, exec, rofi -show drun -show-icons"
        "$mod, T, exec, $terminal"
        "ALT, Tab, cyclenext" # change focus to another window
        "$mod, Tab, cyclenext" # change focus to another window
        "$mod, Tab, bringactivetotop" # bring it to the top
        # Special workspace (scratchpad)
        # "$mainMod, S, togglespecialworkspace, magic"
        # "$mainMod SHIFT, S, movetoworkspace, special:magic"
      ];

      # https://wiki.hyprland.org/Configuring/Binds/#mouse-binds
      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
        "$mod ALT, mouse:272, resizewindow"
      ];

      # https://wiki.hyprland.org/Configuring/Variables/#decoration
      # decoration = {
      #   blur = {
      #     enabled = true;
      #     passes = 1;
      #     size = 3;
      #   };
      #   drop_shadow = "yes";
      #   rounding = 10;
      #   shadow_offset = "0 5";
      #   shadow_range = 4;
      #   shadow_render_power = 3;
      #   # https://www.color-hex.com/
      #   "col.shadow" = "rgba(8673fcee)";
      # };

      # https://wiki.hyprland.org/Configuring/Dwindle-Layout/
      dwindle = {
        preserve_split = "yes";
        pseudotile = "yes";
      };

      # https://wiki.hyprland.org/Configuring/Environment-variables/
      env = lib.mapAttrsToList (name: value: "${name},${toString value}") {
        # Tell Firefox to use Wayland
        MOZ_ENABLE_WAYLAND = "1";
        # Tell Electron apps to use Wayland
        NIXOS_OZONE_WL = "1";
        # XCURSOR_SIZE = 24;
        # XDG_SESSION_TYPE = "wayland"; # Automatically set, so not needed.
      };

      # "$fileManager" = "/run/current-system/sw/bin/thunar";
      # "$fileManager" = "thunar";

      # https://wiki.hyprland.org/Configuring/Variables/#general
      general = {
        # https://wiki.hyprland.org/Configuring/Tearing/
        # allow_tearing = false;
        border_size = 2;
        gaps_in = 5;
        gaps_out = 20;
        layout = "dwindle";
      };

      # https://wiki.hyprland.org/Configuring/Variables/#gestures
      gestures = {
        workspace_swipe = "off";
      };

      # https://wiki.hyprland.org/Configuring/Master-Layout/
      master = {};

      # https://wiki.hyprland.org/Configuring/Keywords/
      "$mainMod" = "SUPER";

      # https://wiki.hyprland.org/Configuring/Variables/#misc
      misc = {
        force_default_wallpaper = 0;
      };

      # "$menu" = "wofi --show drun";
      "$mod" = "SUPER";

      # https://wiki.hyprland.org/Configuring/Monitors/
      # monitor = [
      #   "eDP-1,preferred,left,1"
      #   "DP-1,preferred,right,1"
      # ];
      # monitor = "DP-1,preferred,right,1";
      # monitor = ",preferred,auto,1";
      # monitor = "DP-1,1920x1080@144,0x0,1";

      "$terminal" = "alacritty";
      # "$terminal" = config.programs.alacritty;
      # "$terminal" = "ghostty";
      # "$terminal" = "kitty";

      # https://wiki.hyprland.org/Configuring/Window-Rules/
      # windowrulev2 = "nomaximizerequest, class:.*";
    };

    # https://wiki.hyprland.org/Configuring/XWayland/
    xwayland.enable = true;
  };

  # https://search.nixos.org/options?channel=23.11&show=xdg.portal.config&from=0&size=50&sort=relevance&type=packages&query=xdg.portal
  # https://www.reddit.com/r/NixOS/comments/184hbt6/changes_to_xdgportals/
  config.xdg.portal = {
    enable = true;
    config = {
      common.default = "*";
    };
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-hyprland
    ];
  };
}
