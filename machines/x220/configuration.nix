{ config, inputs, lib, pkgs, ... }:

let
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
{
  imports = [
    <nixos-hardware/lenovo/thinkpad/x220>
    ./hardware-configuration.nix
    ./secrets.nix
  ];

  # TODO: how to import all the home-manager configuration defined in users/jack.nix?
  # In alternative I could define the entire home manager configuration for a single user as a nix flake.

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

  # https://nixos.wiki/wiki/Debug_Symbols
  environment.enableDebugInfo = true;
  
  # Bluetooth configuration for PipeWire
  # https://nixos.wiki/wiki/PipeWire#Bluetooth_Configuration
  environment.etc = {
    "wireplumber/bluetooth.lua.d/51-bluez-config.lua".text = ''
      bluez_monitor.properties = {
			  ["bluez5.enable-sbc-xq"] = true,
			  ["bluez5.enable-msbc"] = true,
			  ["bluez5.enable-hw-volume"] = true,
			  ["bluez5.headset-roles"] = "[ hsp_hs hsp_ag hfp_hf hfp_ag ]"
		  }
    '';
  };

  environment.homeBinInPath = true;

  # environment variables set by Linux PAM
  # https://en.wikipedia.org/wiki/Linux_PAM
  # https://nixos.org/manual/nixos/stable/options#opt-environment.sessionVariables
  # environment.sessionVariables = {};

  # packages available to all users, and automatically updated every time you
  # rebuild the system configuration.
  # https://nixpkgs-manual-sphinx-markedown-example.netlify.app/generated/options-db.xml#environment-systempackages
  environment.systemPackages = with pkgs; [
    age # encryption tool
    alacritty # Open GL terminal emulator
    bandwhich # display network utilization by process, connection and remote IP/hostname
    baobab # disk usage utility
    binutils # tools for manipulating binaries (nm, objdump, strip, etc...)

    (callPackage ../../scripts/ghi.nix { inherit config pkgs; })
    (callPackage ../../scripts/ghw.nix { inherit config pkgs; })

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

    (writeShellApplication {
      name = "show-nixos-org";
      runtimeInputs = [ curl w3m ];
      text = ''
        curl -s 'https://nixos.org' | w3m -dump -T text/html
      '';
    })

    duf # disk usage utility
    eza # fork of exa, a better `ls`
    fd # a better `find`
    feh # image viewer
    gparted # partition editor
    git-cola # git GUI
    gitFull # git + graphical tools like gitk (see https://nixos.wiki/wiki/Git)
    gitg # git GUI
    glxinfo # show information about the GLX implementation
    home-manager # Nix-based user environment configurator
    kitty # GPU-based terminal emulator
    libnotify # send desktop notifications to a notification daemon
    lm_sensors # tools for reading hardware sensors
    meld # visual diff and merge tool
    mtr # network diagnostics tool (basically traceroute + ping)
    ncdu # disk usage utility
    ouch #  compress/decompress files and directories
    plano-theme
    procs # a better `ps`
    pstree # show the set of running processes as a tree
    remmina # remote desktop client
    rofi
    sakura # terminal emulator
    sd # a better `sed`
    sops # editor for encrypting/decrypting JSON, YAML, ini, etc
    st # terminal emulator
    starship # customizable prompt for any shell
    steghide # steganography program
    stow # symlink tool
    tailscale # mesh VPN built on WireGuard
    wabt # WebAssembly binary toolkit
    winetricks # script to install DLLs needed to work around problems in Wine
    wineWowPackages.stable # https://nixos.wiki/wiki/Wine
  ] ++ matePackages ++ xfcePackages ++ xorgPackages;

  # environment variables set at shell initialisation
  # https://nixos.org/manual/nixos/stable/options#opt-environment.variables
  # environment.variables = {};

  # introduced in NixOS 23.11
  environment.xfce.excludePackages = with pkgs.xfce; [
    ristretto # image viewer. I prefer feh.
  ];

  # https://nixos.wiki/wiki/Bluetooth
  # https://github.com/NixOS/nixpkgs/issues/170573
  hardware.bluetooth = {
    enable = true; # enables support for Bluetooth
    powerOnBoot = true; # powers up the default Bluetooth controller on boot
  };
  # For the Blueman applet to work, the blueman service must be enabled system-wide.
  # https://nixos.wiki/wiki/Bluetooth#Pairing_Bluetooth_devices
  services.blueman.enable = true;

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

  # Enable flakes, so we can avoid adding the flag --extra-experimental-features
  # every time we use the nix CLI (e.g. nix build, nix run, etc)
  # https://nixos.wiki/wiki/Flakes#Enable_flakes_permanently_in_NixOS
  # nix.settings.experimental-features = [ "nix-command" "flakes" ];
  # nix.settings.experimental-features = [ "nix-command" ];

  # I prefer to explicitly list all the unfree packages I am using.
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "vscode"
  ];

  # On XFCE, there is no configuration tool for NetworkManager by default: by
  # enabling programs.nm-applet.enable, the graphical applet will be installed
  # and will launch automatically when the graphical session is started.
  programs.nm-applet.enable = true;

  # When PipeWire is enabled, rtkit is optional but recommended
  security.rtkit.enable = true;

  # The PipeWire daemon can be configured to be both an audio server (with
  # PulseAudio and JACK features) and a video capture server.
  # https://nixos.wiki/wiki/PipeWire
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    # jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    # media-session.enable = true;
  };

  # CUPS to print documents
  # https://nixos.wiki/wiki/Printing
  services.printing.enable = true;
  
  # peer-to-peer file synchronization
  # https://nixos.wiki/wiki/Syncthing
  # TODO: should this service be defined here or with Home Manager?
  services.syncthing = {
    enable = true;
    user = "jack";
    dataDir = "/home/jack/Documents";    # Default folder for new synced folders
    configDir = "/home/jack/.config/syncthing";   # Folder for Syncthing's settings and keys
    guiAddress = "0.0.0.0:8384";
  };

  # https://nixos.wiki/wiki/Tailscale
  # https://tailscale.com/blog/nixos-minecraft/
  # https://mynixos.com/nixpkgs/options/services.tailscale
  services.tailscale = {
    enable = true;
    # introduced in NixOS 23.11
    extraUpFlags = [ "--ssh" ];
  };

  # X11 window system
  # https://nixpkgs-manual-sphinx-markedown-example.netlify.app/configuration/x-windows.xml.html
  services.xserver = {
    enable = true;
    # XFCE desktop environment
    # https://nixpkgs-manual-sphinx-markedown-example.netlify.app/configuration/xfce.xml
    desktopManager.xfce.enable = true;
    # LightDM display manager
    displayManager.lightdm.enable = true;
    # https://github.com/NixOS/nixpkgs/blob/master/nixos/modules/services/x11/display-managers/lightdm.nix
    # displayManager.lightdm.greeters.gtk.enable = true;
    # displayManager.lightdm.greeters.slick.enable = true;
    layout = "us";
    # Enable touchpad support (enabled default in most desktopManager).
    # libinput.enable = true;
    xkbVariant = "";
  };

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
  users.users.jack = {
    isNormalUser = true;
    description = "Giacomo Debidda";
    # Beware that the docker group membership is effectively equivalent to being root!
    # https://github.com/moby/moby/issues/9976
    extraGroups = [ "docker" "networkmanager" "wheel" ];
    # Leave this list empty and let Home Manager handle all user-level packages.
    packages = with pkgs; [ ];
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
