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
      # Catppuccin Theme for SDDM
      # catppuccin-sddm-corners

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

    # https://wiki.hyprland.org/Nix/Hyprland-on-NixOS/
    # vimjoyer video about Hyprland configuration https://youtu.be/61wGzIv12Ds?si=Gjj4hJXHs2nujL0z
    # programs.hyprland.enable = true;

    # If we want to run X applications on a machine that uses Wayland as its
    # compositor, we need this compatibility layer.
    programs.xwayland.enable = true;

    programs.waybar.enable = true;

    # Enable a Wayland-compatible display manager (SDDM is highly recommended)
    # https://github.com/sddm/sddm
    # If you want to autologin, see here:
    # https://timothymiller.dev/posts/2024/auto-login-with-nixos-and-kde-plasma/
    services.displayManager.sddm = {
      enable = true;
      # theme = "catppuccin-sddm-corners";
      wayland.enable = true;
    };

    # Keep xserver enabled to ensure XWayland compatibility.
    # within the Hyprland session,
    # Also keep enabled XFCE and LightDM.
    services.xserver = {
      enable = true;
      desktopManager.xfce.enable = true;
      displayManager.lightdm.enable = true;
      xkb.layout = "us,it";
      xkb.options = "grp:alt_space_toggle";
    };
  };
}
