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
      # android-backup-extractor

      # android-studio

      # Android SDK platform tools (adb, fastboot, etc...)
      android-tools

      # A tool for reverse engineering Android apk files
      apktool

      # Non-decompiling Android vulnerability scanner
      trueseeing
    ];

    # https://nixos.wiki/wiki/Android
    programs.adb.enable = true;

    services.udev.packages = with pkgs; [
      # To run apps on an Android device, the computer needs to have installed
      # the udev rules that cover that Android device
      android-udev-rules
    ];

    # In order to use ADB and have the necessary permissions to operate on the
    # connected Android device, the user must be a member of these groups.
    # https://wiki.archlinux.org/title/Android_Debug_Bridge
    # https://developer.android.com/studio/run/device
    users.groups.adbusers = {};
    users.groups.plugdev = {};
  };
}
