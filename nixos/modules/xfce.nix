{pkgs, ...}: let
  xfcePackages = with pkgs; [
    xfce.thunar
    xfce.thunar-volman
    xfce.xfce4-cpugraph-plugin
    xfce.xfce4-notes-plugin
    xfce.xfce4-terminal
    xfce.xfwm4-themes
  ];
in {
  meta = {};

  imports = [];

  options = {};

  config = {
    environment.systemPackages = with pkgs;
      [
        lightlocker
      ]
      ++ xfcePackages;

    services.xserver = {
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
