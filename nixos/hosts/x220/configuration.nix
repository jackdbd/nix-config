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
    nixos-hardware.nixosModules.lenovo-thinkpad-x220
    ./hardware-configuration.nix
    ../../modules/bluetooth.nix
    ../../modules/pipewire.nix
    ../../modules/secrets.nix
    ../../modules/syncthing.nix
    ../../modules/tailscale.nix
    ../../modules/xserver.nix
  ];

  boot.initrd.luks.devices."luks-318ded24-f80a-41ea-96ec-c12aacb3f155".keyFile = "/crypto_keyfile.bin";
  boot.initrd.luks.devices."luks-8b9b15ff-cf4a-4e4a-8564-b577e7099437".keyFile = "/crypto_keyfile.bin";
  boot.initrd.luks.devices."luks-8b9b15ff-cf4a-4e4a-8564-b577e7099437".device = "/dev/disk/by-uuid/8b9b15ff-cf4a-4e4a-8564-b577e7099437";
  # Setup keyfile
  boot.initrd.secrets = {
    "/crypto_keyfile.bin" = null;
  };

  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.enable = true;
  boot.loader.grub.enableCryptodisk = true;
  boot.loader.grub.useOSProber = true;

  # Limit the number of NixOS generations to keep (and that show up in GRUB)
  # https://search.nixos.org/options?channel=23.11&show=boot.loader.grub.configurationLimit&from=0&size=50&sort=relevance&type=packages&query=configurationLimit
  boot.loader.grub.configurationLimit = 50;

  # Some Nix packages provide debugging symbols, but in general they don't.
  # https://nixos.wiki/wiki/Debug_Symbols
  environment.enableDebugInfo = false;

  environment.homeBinInPath = true;

  # environment variables set by Linux PAM
  # https://en.wikipedia.org/wiki/Linux_PAM
  # https://nixos.org/manual/nixos/stable/options#opt-environment.sessionVariables
  # environment.sessionVariables = {};

  # packages available to all users, and automatically updated every time you
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

  # environment variables set at shell initialisation
  # https://nixos.org/manual/nixos/stable/options#opt-environment.variables
  # environment.variables = {};

  # introduced in NixOS 23.11
  environment.xfce.excludePackages = with pkgs.xfce; [
    ristretto # image viewer. I prefer feh.
  ];

  # https://nixos.wiki/wiki/Fonts#Installing_specific_fonts_from_nerdfonts
  fonts.packages = with pkgs; [
    (nerdfonts.override {fonts = ["DroidSansMono" "FiraCode" "JetBrainsMono"];})
  ];

  hardware.pulseaudio.enable = false;

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

  networking.hostName = "x220-nixos";

  # To facilitate network configuration, we use NetworkManager.
  # https://nixpkgs-manual-sphinx-markedown-example.netlify.app/configuration/network-manager.xml.html#networkmanager
  networking.networkmanager.enable = true;

  # Perform garbage collection weekly to maintain low disk usage
  # https://nixos-and-flakes.thiscute.world/nixos-with-flakes/other-useful-tips#reducing-disk-usage
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 1w";
  };

  # Optimize storage
  # You can also manually optimize the store via:
  #    nix-store --optimise
  # Refer to the following link for more details:
  # https://nixos.org/manual/nix/stable/command-ref/conf-file.html#conf-auto-optimise-store
  # TODO: Explain what the downsides of auto optimising the nix store are.
  nix.settings.auto-optimise-store = true;

  # Enable flakes, so we can avoid adding the flag --extra-experimental-features
  # every time we use the nix CLI (e.g. nix build, nix run, etc)
  # https://nixos.wiki/wiki/Flakes#Enable_flakes_permanently_in_NixOS
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Instead of setting allowUnfree to true, I prefer explicitly list all the
  # unfree packages I am using.
  # nixpkgs.config.allowUnfree = true;
  # nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
  #   "google-chrome"
  #   "vscode"
  # ];
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) allowed-unfree-packages;

  # On XFCE, there is no configuration tool for NetworkManager by default: by
  # enabling programs.nm-applet.enable, the graphical applet will be installed
  # and will launch automatically when the graphical session is started.
  programs.nm-applet.enable = true;

  programs.syncthing-wrapper.guiAddress = "127.0.0.1:8384";

  # CUPS to print documents
  # https://nixos.wiki/wiki/Printing
  services.printing.enable = true;

  # Remove sound.enable or set it to false if you had it set previously, as
  # sound.enable is only meant for ALSA-based configurations

  system.autoUpgrade.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.05"; # Did you read the comment?

  time.timeZone = "Europe/Rome";

  # https://nixpkgs-manual-sphinx-markedown-example.netlify.app/configuration/user-mgmt.xml
  users.users.${user} = {
    isNormalUser = true;
    description = "Giacomo Debidda";
    # Beware that the docker group membership is effectively equivalent to being root!
    # https://github.com/moby/moby/issues/9976
    extraGroups = ["docker" "networkmanager" "wheel"];
    # Add to this list only the packages that you would like to install at the
    # user-level, but that are not available in Home Manager.
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

    # If you want to run the docker daemon in rootless mode, you need to specify
    # either the socket path (using thr DOCKER_HOST environment variable) or the
    # CLI context using `docker context` explicitly.
    # https://docs.docker.com/engine/security/rootless/
    # https://docs.docker.com/engine/security/rootless/#client
    # rootless = {
    #   enable = true;
    #   setSocketVariable = true;
    # };
  };
}
