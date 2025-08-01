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

    # https://github.com/NixOS/nixpkgs/blob/nixos-23.11/nixos/modules/services/x11/xserver.nix
    services.xserver = {
      # XFCE desktop environment
      # https://nixpkgs-manual-sphinx-markedown-example.netlify.app/configuration/xfce.xml
      # https://github.com/NixOS/nixpkgs/blob/nixos-23.11/nixos/modules/services/x11/desktop-managers/xfce.nix
      desktopManager.xfce.enable = true;
      # desktopManager.xfce.enableScreensaver = false;
      desktopManager.xfce.enableXfwm = true;

      # LightDM display manager
      # https://github.com/NixOS/nixpkgs/blob/nixos-23.11/nixos/modules/services/x11/display-managers/lightdm.nix
      displayManager.lightdm.enable = false;
      # https://github.com/NixOS/nixpkgs/blob/master/nixos/modules/services/x11/display-managers/lightdm.nix
      # displayManager.lightdm.greeters.gtk.enable = true;
      # displayManager.lightdm.greeters.slick.enable = true;

      xkb.layout = "us,it";
      xkb.options = "grp:alt_space_toggle";
    };
  };
}
