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
      adrgen # CLI to manage Architecture Decision Records (ADR)
      bandwhich # display network utilization by process, connection and remote IP/hostname
      binutils # tools for manipulating binaries (nm, objdump, strip, etc...)
      cmake
      devenv # Fast, Declarative, Reproducible, and Composable Developer Environments
      docker-compose # define and run multi-container applications with Docker
      duf # disk usage utility
      foliate # GTK eBook reader
      gcc # GNU Compiler Collection
      gcc-unwrapped # GNU Compiler Collection
      gdb # GNU project debugger
      gitFull # git + graphical tools like gitk (see https://nixos.wiki/wiki/Git)
      gitg # git GUI
      glxinfo # show information about the GLX implementation
      gnupg # GNU Privacy Guard
      gpa # Graphical user interface for the GnuPG
      gparted # partition editor
      hdparm # tool to get/set ATA/SATA drive parameters under Linux (e.g. for benchmarking disk performance)
      home-manager # Nix-based user environment configurator
      img2pdf # Convert images to PDF via direct JPEG inclusion
      k6 # HTTP load testing tool
      libgcc # GNU Compiler Collection
      libnotify # send desktop notifications to a notification daemon
      lief # Library to Instrument Executable Formats
      linuxKernel.packages.linux_6_1.perf # Linux tools to profile with performance counters
      lmstudio # app for experimenting with local and open-source Large Language Models (LLMs) # TODO: nixos-rebuidl switch fails because of a hash mismatch
      ltrace # tool that intercepts and records dynamic library calls
      minisign # tool for signing files and verifying signatures
      mongodb-compass # MongoDB GUI
      nh # nix cli helper https://github.com/viperML/nh
      nmap # tool for network discovery and security auditing
      ntfs3g # FUSE-based NTFS driver
      pinentry # GnuPG's interface to passphrase input
      poetry # Python dependency management and packaging
      poppler_utils # Rendering library and utilities for PDF files (e.g. pdfunite)
      railway # CLI for Railway (Paas)
      signal-desktop # Private, simple, and secure messenger
      skopeo # CLI for various operations on container images and image repositories
      sops # editor for encrypting/decrypting JSON, YAML, ini, etc
      statix # Nix linter
      stow # symlink tool
      typescript # TypeScript compiler
      unzip
      winetricks # script to install DLLs needed to work around problems in Wine
      wineWowPackages.stable # https://nixos.wiki/wiki/Wine
      zip
    ]
    ++ matePackages
    ++ xfcePackages
    ++ xorgPackages
