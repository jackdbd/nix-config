{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.services.xserver;
in {
  meta = {};

  imports = [];

  options = {
    services.xserver = {
      # already declared in nixos/modules/xserver.nix
      # enable = lib.mkEnableOption "Whether to enable the X server.";
    };
  };

  # X11 window system
  # https://nixpkgs-manual-sphinx-markedown-example.netlify.app/configuration/x-windows.xml.html
  config = mkIf cfg.enable {
    # https://github.com/NixOS/nixpkgs/blob/nixos-23.11/nixos/modules/services/x11/xserver.nix
    services.xserver = {
      # XFCE desktop environment
      # https://nixpkgs-manual-sphinx-markedown-example.netlify.app/configuration/xfce.xml
      # https://github.com/NixOS/nixpkgs/blob/nixos-23.11/nixos/modules/services/x11/desktop-managers/xfce.nix
      desktopManager.xfce.enable = false;
      # desktopManager.xfce.enableScreensaver = false;
      # desktopManager.xfce.enableXfwm = true;

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
