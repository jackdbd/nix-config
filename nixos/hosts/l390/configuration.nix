{
  allowed-unfree-packages,
  config,
  fh,
  inputs,
  lib,
  nil,
  nixos-hardware,
  pkgs,
  user,
  ...
}: {
  imports = [
    # There is no Nix module for the ThinkPad L390. Maybe find a similar model.
    # nixos-hardware.nixosModules.lenovo-thinkpad-l390
    ./hardware-configuration.nix
    {
      environment.systemPackages = [fh.packages.x86_64-linux.default];
    }
    {
      environment.systemPackages = [nil.packages.x86_64-linux.default];
    }
    ../../modules/bluetooth.nix
    ../../modules/fonts.nix
    ../../modules/nix.nix
    ../../modules/pipewire.nix
    ../../modules/printing.nix
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

  environment.systemPackages = import ../../../lib/system-packages.nix {inherit config pkgs;};

  # environment.xfce.excludePackages = with pkgs.xfce; [
  #   ristretto # image viewer.
  # ];

  hardware.bluetooth.enable = true;

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

  nixpkgs.config = {
    allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) allowed-unfree-packages;
    # Obsidian is build on Electron. I don't know why NixOS marks Electron as insecure.
    permittedInsecurePackages = [
      "electron-25.9.0"
    ];
  };

  # On XFCE, there is no configuration tool for NetworkManager by default: by
  # enabling programs.nm-applet.enable, the graphical applet will be installed
  # and will launch automatically when the graphical session is started.
  programs.nm-applet.enable = true;

  services.pipewire.enable = true;
  services.printing.enable = true;
  services.syncthing.enable = true;
  services.tailscale.enable = true;
  services.xserver.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

  time.timeZone = "Europe/Rome";

  users.users.${user} = import ../../users/jack.nix {inherit config pkgs;};

  virtualisation.docker = {
    enable = true;
    autoPrune = {
      enable = true;
      dates = "weekly";
    };
  };
}
