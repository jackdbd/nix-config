{pkgs, ...}: {
  meta = {};

  imports = [];

  options = {};

  config = {
    environment.systemPackages = with pkgs;
      [
        lightlocker
        thunar
        thunar-volman
        xfce4-cpugraph-plugin
        xfce4-notes-plugin
        xfce4-terminal
        xfwm4-themes
      ];

    services.xserver = {
      desktopManager.wallpaper.mode = "scale";

      # XFCE desktop environment
      # https://github.com/NixOS/nixpkgs/blob/master/nixos/modules/services/x11/xserver.nix
      desktopManager.xfce.enable = true;
      desktopManager.xfce.enableScreensaver = false;
      desktopManager.xfce.enableXfwm = true;

      xkb.layout = "us,it";
      xkb.options = "grp:alt_space_toggle";
    };
  };
}
