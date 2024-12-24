{
  config,
  lib,
  pkgs,
  ...
}:
with lib; {
  meta = {};

  imports = [];

  options = {};

  # config.environment.systemPackages = with pkgs; [
  #   nerdfonts
  # ];

  config.fonts = {
    # Enable all fonts from this list:
    # https://github.com/NixOS/nixpkgs/blob/d02d818f22c777aa4e854efc3242ec451e5d462a/nixos/modules/config/fonts/packages.nix#L34
    enableDefaultPackages = true;
    packages = with pkgs; [
      # Enable a few fonts from this list:
      # https://github.com/NixOS/nixpkgs/tree/master/pkgs/data/fonts
      alegreya
      # NixOS contains only this subset of the entire Nerd Fonts package.
      # Here we select only a subset of that subset.
      # https://nixos.wiki/wiki/Fonts#Installing_only_specific_nerdfonts
      nerd-fonts.droid-sans-mono
      nerd-fonts.fira-code
      nerd-fonts.jetbrains-mono
      nerd-fonts.space-mono
      noto-fonts
      noto-fonts-cjk-sans # Chinese, Japanese, Korean
      noto-fonts-emoji # color emojis
      source-code-pro
      ubuntu_font_family
      weather-icons
    ];

    fontconfig.enable = true;
  };
}
