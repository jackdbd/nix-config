{pkgs, ...}: {
  meta = {};

  imports = [];

  options = {};

  config = {
    boot.supportedFilesystems = ["exfat" "ntfs"];

    environment.systemPackages = with pkgs; [
      exfat # exFAT driver
      exfatprogs # utility for formatting and repair exFAT filesystems
      ntfs3g # NTFS driver
    ];

    services.gvfs.enable = true; # allows Thunar to mount disks
    services.udisks2.enable = true; # allows Udisks to mount disks
  };
}
