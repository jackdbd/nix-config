{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.programs.chromium;
in {
  meta = {};

  imports = [];

  options = {
    programs.chromium = {
      # enable = mkEnableOption "Install Chromium";
      enable-octotree = mkEnableOption "Whether to enable the Octotree Chrome extension";
    };
  };

  config = mkIf cfg.enable {
    home.packages = [cfg.package];

    # Configuration for Chromium and its extensions
    # https://codeberg.org/davidak/nixos-config/src/branch/main/profiles/desktop.nix
    # https://github.com/gvolpe/nix-config/blob/master/home/programs/browsers/chromium.nix
    # https://github.com/gvolpe/nix-config/blob/master/home/programs/browsers/extensions.nix
    # https://rycee.gitlab.io/home-manager/options.html#opt-programs.chromium.commandLineArgs
    programs.chromium = {
      commandLineArgs = [];
      extensions = import ../../lib/chrome-extensions.nix {
        enable-octotree = cfg.enable-octotree;
      };
    };
  };
}
