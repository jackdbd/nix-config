{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.programs.chromium-wrapper;
in {
  imports = [];

  options.programs.chromium-wrapper = {
    enable = mkEnableOption "Install Chromium";
    should-install-extensions = mkEnableOption "Whether to install Chrome extensions";
  };

  meta = {};

  # Configuration for Chromium and its extensions
  # https://codeberg.org/davidak/nixos-config/src/branch/main/profiles/desktop.nix
  # https://github.com/gvolpe/nix-config/blob/master/home/programs/browsers/chromium.nix
  # https://github.com/gvolpe/nix-config/blob/master/home/programs/browsers/extensions.nix
  config.programs.chromium = mkIf cfg.enable {
    enable = true;
    # https://rycee.gitlab.io/home-manager/options.html#opt-programs.chromium.commandLineArgs
    commandLineArgs = [];
    extensions = mkIf cfg.should-install-extensions (import ../../lib/chrome-extensions.nix);
  };
}
