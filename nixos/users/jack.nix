{
  config,
  pkgs,
}: {
  isNormalUser = true;
  description = "Giacomo Debidda";
  # Beware that the docker group membership is effectively equivalent to being root!
  # https://github.com/moby/moby/issues/9976
  extraGroups = ["docker" "networkmanager" "wheel"];
  # Add to this list only the packages that you would like to install at the
  # user-level, but that are not available in Home Manager.
  packages = with pkgs; [
    (callPackage ../scripts/ghi.nix {inherit config pkgs;})
    (callPackage ../scripts/ghw.nix {inherit config pkgs;})
    git-cola # git GUI
    kitty # GPU-based terminal emulator
    meld # visual diff and merge tool
    ouch #  compress/decompress files and directories
    plano-theme # flat theme for GNOME and Xfce
    remmina # remote desktop client
    sakura # terminal emulator
    sd # a better `sed`
    starship # customizable prompt for any shell
    steghide # steganography program
    wabt # WebAssembly binary toolkit
  ];
}
