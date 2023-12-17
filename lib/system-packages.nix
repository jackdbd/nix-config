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
      age # encryption tool
      alacritty # Open GL terminal emulator
      bandwhich # display network utilization by process, connection and remote IP/hostname
      baobab # disk usage utility
      binutils # tools for manipulating binaries (nm, objdump, strip, etc...)
      duf # disk usage utility
      eza # fork of exa, a better `ls`
      fd # a better `find`
      feh # image viewer
      gitFull # git + graphical tools like gitk (see https://nixos.wiki/wiki/Git)
      gitg # git GUI
      glxinfo # show information about the GLX implementation
      gparted # partition editor
      home-manager # Nix-based user environment configurator
      libnotify # send desktop notifications to a notification daemon
      lm_sensors # tools for reading hardware sensors
      lshw # detailed information on the hardware configuration of the machine
      mtr # network diagnostics tool (basically traceroute + ping)
      ncdu # disk usage utility
      procs # a better `ps`
      pstree # show the set of running processes as a tree
      rofi
      sops # editor for encrypting/decrypting JSON, YAML, ini, etc
      stow # symlink tool
      tailscale # mesh VPN built on WireGuard
      usbutils # tools for working with USB devices, such as lsusb
      winetricks # script to install DLLs needed to work around problems in Wine
      wineWowPackages.stable # https://nixos.wiki/wiki/Wine
    ]
    ++ matePackages
    ++ xfcePackages
    ++ xorgPackages
