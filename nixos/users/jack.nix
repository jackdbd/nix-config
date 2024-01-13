{
  config,
  pkgs,
}: {
  description = "Giacomo Debidda";
  isNormalUser = true;

  extraGroups = [
    # In order to use ADB and have the necessary permissions to operate on the
    # connected Android device, the user must be a member of these groups.
    # https://wiki.archlinux.org/title/Android_Debug_Bridge
    # https://developer.android.com/studio/run/device
    "adbusers"
    "plugdev"

    # Beware that the docker group membership is effectively equivalent to being root!
    # https://github.com/moby/moby/issues/9976
    "docker"

    "networkmanager"

    # group I use for testing
    "skaters"

    "wheel"
  ];

  # Add to this list only the packages that you would like to install at the
  # user-level, but that cannot be managed by Home Manager.
  packages = with pkgs; [
    # These scripts use the sops NixOS module exposed by sops-nix. Since it's a
    # NixOS module, these scripts cannot be managed by Home Manager.
    (callPackage ../scripts/debug-secrets.nix {inherit config pkgs;})
    (callPackage ../scripts/ghi.nix {inherit config pkgs;})
    (callPackage ../scripts/ghw.nix {inherit config pkgs;})
  ];
}
