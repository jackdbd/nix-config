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
      # NixOS contains only this subset of the entire Nerd Fonts package:
      # https://github.com/NixOS/nixpkgs/blob/1b9f6e68c2f3ae68c94e6003bbcddb495161564e/pkgs/data/fonts/nerdfonts/shas.nix
      # Here we select only a subset of that subset.
      # https://nixos.wiki/wiki/Fonts#Installing_specific_fonts_from_nerdfonts
      (nerdfonts.override {
        fonts = [
          "DroidSansMono"
          "FiraCode"
          "JetBrainsMono"
          "NerdFontsSymbolsOnly"
          "SpaceMono"
        ];
      })
      source-code-pro
      ubuntu_font_family
      weather-icons
    ];

    fontconfig.enable = true;
  };
}
