{
  allowed-unfree-packages,
  config,
  inputs,
  lib,
  nixos-hardware,
  pkgs,
  sops-nix,
  user,
  ...
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
in {
  imports = [
    # There is no Nix module for the ThinkPad L390. Maybe find a similar model.
    # nixos-hardware.nixosModules.lenovo-thinkpad-l390
    ./hardware-configuration.nix
    ../../modules/bluetooth.nix
    ../../modules/pipewire.nix
    ../../modules/secrets.nix
    ../../modules/syncthing.nix
    ../../modules/tailscale.nix
    ../../modules/xserver.nix
  ];

  boot.initrd.luks.devices."luks-b3f9c76b-a5c8-4cde-ac71-535947e59429".device = "/dev/disk/by-uuid/b3f9c76b-a5c8-4cde-ac71-535947e59429";

  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.configurationLimit = 50;
  boot.loader.systemd-boot.enable = true;

  environment.enableDebugInfo = false;

  environment.homeBinInPath = true;

  # Packages available to all users, and automatically updated every time you
  # rebuild the system configuration.
  # https://nixpkgs-manual-sphinx-markedown-example.netlify.app/generated/options-db.xml#environment-systempackages
  environment.systemPackages = with pkgs;
    [
      age # encryption tool
      alacritty # Open GL terminal emulator
      bandwhich # display network utilization by process, connection and remote IP/hostname
      baobab # disk usage utility
      binutils # tools for manipulating binaries (nm, objdump, strip, etc...)
      (writeShellScriptBin "debug-secrets" ''
        printf "=== DEBUG SECRETS ===\n"
        echo "defaultSopsFile is at ${config.sops.defaultSopsFile}"

        printf "\ngithub_token_workflow_developer\n"
        echo "secret found at ${config.sops.secrets.github_token_workflow_developer.path}"
        echo "secret is $(cat ${config.sops.secrets.github_token_workflow_developer.path})"

        echo "gh auth status (to check that GITHUB_TOKEN is set)"
        export GITHUB_TOKEN=$(cat ${config.sops.secrets.github_token_workflow_developer.path})
        gh auth status

        printf "\nnpm_token_read_all_packages\n"
        echo "secret found at ${config.sops.secrets."nested_secret/npm_token_read_all_packages".path}"
        echo "secret is $(cat ${config.sops.secrets."nested_secret/npm_token_read_all_packages".path})"

        printf "\ndeeply-nested\n"
        echo "secret found at ${config.sops.secrets."abc/def/ghi/deeply-nested".path}"
        echo "secret is $(cat ${config.sops.secrets."abc/def/ghi/deeply-nested".path})"
      '')
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
    ++ xorgPackages;

  environment.xfce.excludePackages = with pkgs.xfce; [
    ristretto # image viewer. I prefer feh.
  ];

  # https://nixos.wiki/wiki/Fonts#Installing_specific_fonts_from_nerdfonts
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      # https://nixos.wiki/wiki/Fonts#Installing_specific_fonts_from_nerdfonts
      (nerdfonts.override {fonts = ["DroidSansMono" "FiraCode" "JetBrainsMono"];})
      ubuntu_font_family
    ];
  };

  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "it_IT.UTF-8";
    LC_IDENTIFICATION = "it_IT.UTF-8";
    LC_MEASUREMENT = "it_IT.UTF-8";
    LC_MONETARY = "it_IT.UTF-8";
    LC_NAME = "it_IT.UTF-8";
    LC_NUMERIC = "it_IT.UTF-8";
    LC_PAPER = "it_IT.UTF-8";
    LC_TELEPHONE = "it_IT.UTF-8";
    LC_TIME = "it_IT.UTF-8";
  };

  networking.hostName = "l390-nixos"; # Define your hostname.

  networking.networkmanager.enable = true;

  # Perform garbage collection weekly to maintain low disk usage
  # https://nixos-and-flakes.thiscute.world/nixos-with-flakes/other-useful-tips#reducing-disk-usage
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 1w";
  };

  nix.settings.auto-optimise-store = true;

  nix.settings.experimental-features = ["nix-command" "flakes"];

  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) allowed-unfree-packages;

  # On XFCE, there is no configuration tool for NetworkManager by default: by
  # enabling programs.nm-applet.enable, the graphical applet will be installed
  # and will launch automatically when the graphical session is started.
  programs.nm-applet.enable = true;

  programs.syncthing-wrapper.guiAddress = "127.0.0.1:8384";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

  time.timeZone = "Europe/Rome";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${user} = {
    isNormalUser = true;
    description = "Giacomo Debidda";
    extraGroups = ["docker" "networkmanager" "wheel"];
    packages = with pkgs; [
      (callPackage ../../scripts/ghi.nix {inherit config pkgs;})
      (callPackage ../../scripts/ghw.nix {inherit config pkgs;})
      git-cola # git GUI
      kitty # GPU-based terminal emulator
      meld # visual diff and merge tool
      ouch #  compress/decompress files and directories
      plano-theme # flat theme for GNOME and Xfce
      remmina # remote desktop client
      sakura # terminal emulator
      sd # a better `sed`
      (writeShellApplication {
        name = "show-nixos-org";
        runtimeInputs = [curl w3m];
        text = ''
          curl -s 'https://nixos.org' | w3m -dump -T text/html
        '';
      })
      starship # customizable prompt for any shell
      steghide # steganography program
      wabt # WebAssembly binary toolkit
    ];
  };

  virtualisation.docker = {
    enable = true;
    autoPrune = {
      enable = true;
      dates = "weekly";
    };
  };
}
