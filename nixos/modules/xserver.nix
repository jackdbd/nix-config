{
  config,
  lib,
  pkgs,
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
    environment.systemPackages = with pkgs; [
      catppuccin-sddm-corners
    ];

    services.displayManager.sddm = {
      enable = true;
      theme = "catppuccin-sddm-corners";
    };

    # https://github.com/NixOS/nixpkgs/blob/nixos-23.11/nixos/modules/services/x11/xserver.nix
    services.xserver = {
      # XFCE desktop environment
      # https://nixpkgs-manual-sphinx-markedown-example.netlify.app/configuration/xfce.xml
      # https://github.com/NixOS/nixpkgs/blob/nixos-23.11/nixos/modules/services/x11/desktop-managers/xfce.nix
      desktopManager.xfce.enable = true;
      desktopManager.xfce.enableScreensaver = false;
      desktopManager.xfce.enableXfwm = true;

      xkb.layout = "us,it";
      xkb.options = "grp:alt_space_toggle";
    };
  };
}
