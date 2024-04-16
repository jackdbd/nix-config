{
  config,
  lib,
  pkgs,
  ...
}: {
  meta = {};

  imports = [];

  options = {};

  config = {
    environment.systemPackages = with pkgs; [
      rofi-wayland
      # https://github.com/LGFae/swww
      swww
      waybar
    ];

    # https://wiki.hyprland.org/Nix/Hyprland-on-NixOS/
    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
    };

    programs.waybar = {
      enable = true;
    };
  };
}
