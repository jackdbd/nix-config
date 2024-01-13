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

      # android-studio-stable

      # Android SDK platform tools (adb, fastboot, etc...)
      android-tools

      # To run apps on an Android device, the computer needs to have installed
      # the udev rules that cover that Android device
      android-udev-rules

      # A tool for reverse engineering Android apk files
      apktool

      # Non-decompiling Android vulnerability scanner
      trueseeing
    ];
  };
}
