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

  config.fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      # Enable a few fonts from this list:
      # https://github.com/NixOS/nixpkgs/tree/master/pkgs/data/fonts
      alegreya
      dina-font
      fira-code # https://github.com/NixOS/nixpkgs/blob/master/pkgs/data/fonts/fira-code/default.nix
      fira-code-symbols # https://github.com/NixOS/nixpkgs/blob/master/pkgs/data/fonts/fira-code/symbols.nix
      iosevka # https://github.com/NixOS/nixpkgs/blob/master/pkgs/data/fonts/iosevka/default.nix
      liberation_ttf
      mplus-outline-fonts.githubRelease
      # NixOS contains only this subset of the entire Nerd Fonts package.
      # Here we select only a subset of that subset.
      # https://nixos.wiki/wiki/Fonts#Installing_only_specific_nerdfonts
      nerd-fonts.droid-sans-mono
      nerd-fonts.jetbrains-mono
      nerd-fonts.space-mono
      noto-fonts
      noto-fonts-color-emoji
      noto-fonts-cjk-sans # Chinese, Japanese, Korean
      noto-fonts-emoji # color emojis
      source-code-pro
      ubuntu_font_family
      weather-icons
    ];

    # https://github.com/NixOS/nixpkgs/blob/master/nixos/modules/config/fonts/fontconfig.nix
    fontconfig = {
      defaultFonts = {
        emoji = ["Noto Color Emoji"];
        monospace = ["JetBrainsMono Nerd Font"];
      };
    };
  };
}
