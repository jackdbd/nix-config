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
      android-tools # Android SDK platform tools (adb, fastboot, etc...)
      apktool # A tool for reverse engineering Android apk files
      trueseeing # Non-decompiling Android vulnerability scanner
    ];
  };
}
