{
  lib,
  pkgs,
  ...
}: {
  config.programs.waybar = {
    enable = true;
  };

  # config.programs.wofi.enable = true;

  config.wayland.windowManager.wayfire = {
    enable = true;

    # Minimal example config, you'd add more to ~/.config/wayfire.ini
    # or via home-manager wayland.windowManager.wayfire.settings
    settings = {
      # core = {
      #   plugins = ["vswitch" "switcher" "decoration" "water"]; # Example plugins
      # };
      env = {
        MOZ_ENABLE_WAYLAND = "1"; # Tell Firefox to use Wayland
        NIXOS_OZONE_WL = "1"; # Tell Electron apps to use Wayland
        # XDG_SESSION_TYPE = "wayland"; # Automatically set, so not needed.
      };
    };

    xwayland.enable = true;
  };

  # You might also want to enable XWayland for X11 application compatibility
  # config.services.xserver.xwayland.enable = true;
}
