{ config, lib, pkgs, ... }:

{
  imports = [];
  
  options = {};

  # X11 window system
  # https://nixpkgs-manual-sphinx-markedown-example.netlify.app/configuration/x-windows.xml.html
  config = {
    services.xserver = {
      enable = true;
      # XFCE desktop environment
      # https://nixpkgs-manual-sphinx-markedown-example.netlify.app/configuration/xfce.xml
      desktopManager.xfce.enable = true;
      # LightDM display manager
      displayManager.lightdm.enable = true;
      # https://github.com/NixOS/nixpkgs/blob/master/nixos/modules/services/x11/display-managers/lightdm.nix
      # displayManager.lightdm.greeters.gtk.enable = true;
      # displayManager.lightdm.greeters.slick.enable = true;
      layout = "us";
      # Enable touchpad support (enabled default in most desktopManager).
      # libinput.enable = true;
      xkbVariant = "";
    };
  };

  meta = {};
}

