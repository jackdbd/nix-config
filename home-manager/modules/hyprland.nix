{
  config,
  lib,
  pkgs,
  user,
  ...
}: {
  meta = {};

  imports = [];

  options = {};

  config.home.packages = [];

  # https://wiki.hyprland.org/Nix/Hyprland-on-Home-Manager/
  # https://nixos.wiki/wiki/Hyprland#Configuration
  # https://home-manager-options.extranix.com/?query=wayland.windowManager&release=master
  # https://github.com/FlafyDev/nixos-config/blob/61ea9fea72db1cb449e7c0266cd28aac7c23d9af/modules/display/hyprland/default.nix
  config.wayland.windowManager.hyprland = {
    enable = true;

    # Extra configuration lines to add to `~/.config/hypr/hyprland.conf`.
    # https://github.com/nix-community/home-manager/blob/1c43dcfac48a2d622797f7ab741670fdbcf8f609/modules/services/window-managers/hyprland.nix#L159
    extraConfig = ''
    '';

    plugins = [];

    settings = {
      # https://wiki.hyprland.org/Configuring/Animations/
      animations = {
        enabled = "yes";
      };

      # https://wiki.hyprland.org/Configuring/Binds/
      bind = [
        "$mainMod, Q, exec, $terminal"
        "$mainMod, C, killactive"
        "$mainMod, M, exit"
        "$mainMod, E, exec $fileManager"
        "$mainMod, A, exec, rofi -show drun -show-icons"
        # "$mainMod, S, exec, rofi -show drun -show-icons"
        # grave is the key with backtick/tilde
        # "$mainMod, grave, exec, rofi -show drun -show-icons"

        # Move focus with mainMod + arrow keys
        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up, movefocus, u"
        "$mainMod, down, movefocus, d"

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
      decoration = {
        blur = {
          enabled = true;
          passes = 1;
          size = 3;
        };
        drop_shadow = "yes";
        rounding = 10;
        shadow_offset = "0 5";
        shadow_range = 4;
        shadow_render_power = 3;
        # https://www.color-hex.com/
        "col.shadow" = "rgba(8673fcee)";
      };

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
        # XDG_SESSION_TYPE = "wayland";
      };

      # "$fileManager" = "/run/current-system/sw/bin/thunar";
      "$fileManager" = "thunar";

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

      master = {
        # https://wiki.hyprland.org/Configuring/Master-Layout/
        new_is_master = true;
      };

      # https://wiki.hyprland.org/Configuring/Keywords/
      "$mainMod" = "SUPER";

      # https://wiki.hyprland.org/Configuring/Variables/#misc
      misc = {
        force_default_wallpaper = 0;
      };

      # "$menu" = "wofi --show drun";
      "$mod" = "SUPER";

      # https://wiki.hyprland.org/Configuring/Monitors/
      monitor = ",preferred,auto,1";
      # monitor = "DP-1,1920x1080@144,0x0,1";

      "$terminal" = "alacritty";
      # "$terminal" = config.programs.alacritty;
      # "$terminal" = "kitty";

      # https://wiki.hyprland.org/Configuring/Window-Rules/
      windowrulev2 = "nomaximizerequest, class:.*";
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
    extraPortals = [pkgs.xdg-desktop-portal-gtk];
    # extraPortals = [pkgs.xdg-desktop-portal-hyprland];
  };
}
