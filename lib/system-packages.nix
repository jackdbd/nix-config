{
  config,
  pkgs,
}: let
  matePackages = with pkgs; [
    mate.atril # PDF viewer (it's a fork of evince)
  ];
  xfcePackages = with pkgs; [
    xfce.xfce4-cpugraph-plugin
    xfce.xfce4-notes-plugin
    xfce.xfce4-terminal
    xfce.xfwm4-themes
  ];
  xorgPackages = with pkgs; [
    xorg.xkill
  ];
in
  with pkgs;
  # Packages available to all users, and automatically updated every time you
  # rebuild the system configuration.
    [
      bandwhich # display network utilization by process, connection and remote IP/hostname
      binutils # tools for manipulating binaries (nm, objdump, strip, etc...)
      duf # disk usage utility
      gitFull # git + graphical tools like gitk (see https://nixos.wiki/wiki/Git)
      gitg # git GUI
      glxinfo # show information about the GLX implementation
      gnupg # GNU Privacy Guard
      gpa # Graphical user interface for the GnuPG
      gparted # partition editor
      home-manager # Nix-based user environment configurator
      libnotify # send desktop notifications to a notification daemon
      linuxKernel.packages.linux_6_1.perf # Linux tools to profile with performance counters
      ltrace # tool that intercepts and records dynamic library calls
      minisign # tool for signing files and verifying signatures
      nmap # tool for network discovery and security auditing
      pinentry # GnuPG's interface to passphrase input
      sops # editor for encrypting/decrypting JSON, YAML, ini, etc
      stow # symlink tool
      winetricks # script to install DLLs needed to work around problems in Wine
      wineWowPackages.stable # https://nixos.wiki/wiki/Wine
    ]
    ++ matePackages
    ++ xfcePackages
    ++ xorgPackages
