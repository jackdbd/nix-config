{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.services.lockscreen;
  inactiveInterval = 1; # in minutes
in {
  imports = [];

  options.services.lockscreen = {
    not-when-audio = mkEnableOption "Disable lockscreen when some audio is playing";
    not-when-fullscreen = mkEnableOption "Disable lockscreen when in full screen";
  };

  meta = {};

  # betterlockscreen is a screen-locker module
  config.services.betterlockscreen = {
    inherit inactiveInterval;
    enable = true;
    arguments = ["pixel"];
  };

  config.services.screen-locker = {
    inherit inactiveInterval;
    enable = true;
    # lockCmd = "${pkgs.betterlockscreen}/bin/betterlockscreen --lock pixel";
    lockCmd = "xflock4";
    xautolock.enable = true;
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
