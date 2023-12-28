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
      # already declared in home-manager/modules/chromium.nix
      # enable = mkEnableOption "Install Chromium";
      should-install-extensions = mkEnableOption "Whether to install Chrome extensions";
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
      extensions = mkIf cfg.should-install-extensions (import ../../lib/chrome-extensions.nix);
    };
  };
}
