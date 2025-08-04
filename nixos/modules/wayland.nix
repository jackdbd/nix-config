{pkgs, ...}: {
  meta = {};

  imports = [];

  options = {};

  config = {
    environment.sessionVariables = {
      # Tell Firefox to use Wayland
      MOZ_ENABLE_WAYLAND = "1";
      # Hint Electron apps (e.g. VS Code) to use Wayland instead of X11.
      # https://nixos.wiki/wiki/Visual_Studio_Code#Wayland
      NIXOS_OZONE_WL = "1";
    };

    environment.systemPackages = with pkgs; [
      # App launcher
      # https://youtu.be/61wGzIv12Ds?si=QiPrksKw9M3Hnbrh&t=222
      rofi-wayland

      # Wallpaper daemon
      # https://github.com/LGFae/swww
      # swww

      # Status bar for wlroots Wayland compositors
      # https://github.com/Alexays/Waybar
      waybar
    ];

    hardware = {
      graphics.enable = true;
    };

    # If we want to run X applications on a machine that uses Wayland as its
    # compositor, we need this compatibility layer.
    programs.xwayland.enable = true;

    programs.waybar.enable = true;

    # Keep xserver enabled to ensure XWayland compatibility within the
    # wayland-based compositor (e.g. Labwc) session.
    services.xserver.enable = true;
  };
}
