{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.services.lockscreen;
  inactiveInterval = 10; # in minutes
  effect = "pixel";
  lockCmd = "${pkgs.betterlockscreen}/bin/betterlockscreen --lock ${effect}";
  # lockCmd = "xflock4";
in {
  imports = [];

  options.services.lockscreen = {
    not-when-audio = mkEnableOption "Don't lock the screen when there's some audio playing";
    not-when-fullscreen = mkEnableOption "Don't lock when there's a fullscreen application";
  };

  meta = {};

  # betterlockscreen is a screen-locker module
  config.services.betterlockscreen = {
    inherit inactiveInterval;
    enable = true;
    arguments = [effect];
  };

  config.services.screen-locker = {
    inherit inactiveInterval lockCmd;
    enable = true;
    # we disable xautolock because we use xidlehook instead
    xautolock.enable = false;
  };

  # https://github.com/nix-community/home-manager/blob/master/modules/services/xidlehook.nix
  # https://github.com/jD91mZM2/xidlehook
  config.services.xidlehook = {
    enable = true;
    detect-sleep = true;
    not-when-audio =
      if cfg.not-when-audio
      then true
      else false;
    not-when-fullscreen =
      if cfg.not-when-fullscreen
      then true
      else false;
  };

  config.services.xscreensaver.enable = false;
}
