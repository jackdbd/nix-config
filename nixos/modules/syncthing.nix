{
  config,
  lib,
  user,
  ...
}:
with lib; let
  cfg = config.services.syncthing;
  laptops = ["ThinkPad L380" "ThinkPad L390"];
  phones = ["Moto G55 5G"];
in {
  meta = {};

  imports = [];

  options = {
    services.syncthing = {
      # already declared in nixos/modules/syncthing.nix
      # enable = mkEnableOption "Enable  (peer-to-peer file synchronization)";
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [cfg.package];

    # The systemd unit for the Syncthing service can be found at:
    # /etc/systemd/system/syncthing.service
    #
    # Useful commands:
    # systemctl --system status --user syncthing.service
    # journalctl --system --unit=syncthing.service --follow
    # systemd-analyze security --system
    # systemd-analyze security --system syncthing.service
    services.syncthing = {
      inherit user;

      # Folder for Syncthing's settings and keys
      configDir = "/home/${user}/.config/syncthing";

      # Default folder for new synced folders. Can I disable it?
      dataDir = "/home/${user}/Documents";

      # Consider using a secret for the Syncthing GUI. But how can a non-NixOS
      # host (e.g. a laptop running Xubuntu) decrypt this secret? I think I would
      # need to use the sops-nix Home Manager module, not the sops-nix NixOS module.
      # extraOptions.gui = {
      #   user = "username";
      #   password = "password";
      # };

      # This causes an infinite recursion. Why?
      # guiAddress = cfg.guiAddress;

      # Override any devices added or deleted through the WebUI
      overrideDevices = true;
      # Overrides any folders added or deleted through the WebUI
      overrideFolders = true;

      settings.devices = {
        "Moto G55 5G" = {
          id = "E4UI7ZU-U6IAELP-QXZQGT2-LXYFHKF-YZALZYB-GAFDHXW-JKY46AS-ENJQFQR";
          # autoAcceptFolders = true;
        };
        "ThinkPad L380" = {
          id = "O7TN5GB-HVEFBUW-C5N6F6A-JVQSECT-PT7EIQD-DDY25FD-RKHPSAG-TUPR2A7";
        };
        "ThinkPad L390" = {
          id = "KPVHYCY-WBF7QTW-UVEOQN4-BKQDYZB-QFBSYOQ-65SCSFR-LGIFVE4-ESN6GQQ";
        };
      };

      settings.folders = {
        # Folder ID in Syncthing
        "ipxyn-ow6d6" = {
          # Folder name in Syncthing
          label = "Calibre Library";
          # Which folder to add to Syncthing
          path = "/home/${user}/Documents/calibre-library";
          # Which devices to share the folder with
          devices = laptops;
          # versioning.type = "simple"; # one of "external", "simple", "staggered", "trashcan"
        };
        "moto_g55_5g_fq64-photos" = {
          label = "Moto G55 5G Camera";
          path = "/home/${user}/Pictures/moto-g55-5g-camera";
          devices = laptops ++ ["Moto G55 5G"];
        };
        "mihyn-ggmuw" = {
          label = "Shared Docs";
          path = "/home/${user}/Documents/shared-documents";
          devices = laptops ++ phones;
        };
        "prz5n-egjgc" = {
          label = "Shared Music";
          path = "/home/${user}/Music/shared-music";
          devices = laptops ++ phones;
        };
        "ewwca-actnr" = {
          label = "Shared Pics";
          path = "/home/${user}/Pictures/shared-pictures";
          devices = laptops;
        };
      };

      # Create a systemd unit for the syncthing service in the systemd system
      # instance, and auto launch it at system startup.
      # https://github.com/NixOS/nixpkgs/blob/d02d818f22c777aa4e854efc3242ec451e5d462a/nixos/modules/services/networking/syncthing.nix#L648
      systemService = true;
    };
  };
}
