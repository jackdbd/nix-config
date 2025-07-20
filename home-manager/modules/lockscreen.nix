{
  # config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cancel-cmd = "";
  # cfg = config.services.lockscreen;
  idle-seconds-min = 10;
  idle-seconds-max = 3600;
  idle-seconds-default = 300;
  # lock-cmd = "xflock4"; # see xfconf.nix. Maybe accept this as an option
  lock-cmd = "pidof hyprlock || hyprlock"; # https://flarexes.com/hyprland-getting-started-configure-screen-lock-brightness-volume-authentication-and-more
in {
  imports = [];

  options.services.lockscreen = {
    not-when-audio = mkEnableOption "Don't lock the screen when there's some audio playing";
    not-when-fullscreen = mkEnableOption "Don't lock when there's a fullscreen application";
    idle-seconds = mkOption {
      type = types.ints.between idle-seconds-min idle-seconds-max;
      default = idle-seconds-default;
      description = ''
        Inactive time interval in seconds after which the screen will be locked.
        Minimum ${idle-seconds-min} seconds, maximum ${idle-seconds-max} seconds, default ${idle-seconds-default}.
      '';
    };
  };

  meta = {};

  config.home.packages = [
    pkgs.betterlockscreen
    pkgs.xidlehook
  ];

  # We don't use betterlockscreen as a service. We just need the program.
  config.services.betterlockscreen.enable = false;

  config.services.screen-locker.enable = false;
  # we disable xautolock because we use xidlehook instead
  # config.services.screen-locker.xautolock.enable = false;

  # foreground program:
  # xidlehook --not-when-audio --detect-sleep --timer 5 xflock4 ''

  # systemd service:
  # systemctl --user status xidlehook

  # https://github.com/nix-community/home-manager/blob/master/modules/services/xidlehook.nix
  # https://github.com/jD91mZM2/xidlehook
  # https://mipmip.github.io/home-manager-option-search/?query=xidlehook
  # config.services.xidlehook = {
  #   enable = true;
  #   detect-sleep = true;
  #   not-when-audio =
  #     if cfg.not-when-audio
  #     then true
  #     else false;
  #   not-when-fullscreen =
  #     if cfg.not-when-fullscreen
  #     then true
  #     else false;
  #   timers = [
  #     {
  #       delay = cfg.idle-seconds;
  #       command = lock-cmd;
  #       canceller = cancel-cmd;
  #     }
  #   ];
  # };

  config.services.xscreensaver.enable = false;
}
