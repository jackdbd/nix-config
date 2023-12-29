{
  config,
  lib,
  pkgs,
  user,
  ...
}:
with lib; let
  cfg = config.services.syncthing;
  laptops = ["ThinkPad L380" "ThinkPad L390" "ThinkPad X220"];
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

      # Consider using a secret for the Syncthing GUI. But how does a non-NixOS
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
        "Redmi Note 9S" = {
          id = "7WJ47ZP-O776CHO-OELIPNH-GUOZHA4-UYYZ3WS-PL5BE6L-INDDN3D-FHKDDQQ";
        };
        "ThinkPad L380" = {
          id = "ENRVVVG-BKZ3LJH-ZHKXKPH-JW2HUF7-BNPWHFF-YDNPR2Z-UCNJBEL-T6C45AV";
        };
        "ThinkPad L390" = {
          id = "ZUVYNEP-4CMUUH5-6P75652-VYIEQLU-COK4UYC-4RUIO4F-7GAOYDE-BVDP7AM";
        };
        "ThinkPad X220" = {
          id = "WQ2BV2F-VOYX4RT-WBBI26I-U3KCTCV-JRGRQUZ-MNT44DV-COAMMYQ-JPF5EAN";
          # autoAcceptFolders = true;
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
        "mihyn-ggmuw" = {
          label = "Shared Docs";
          path = "/home/${user}/Documents/shared-documents";
          devices = laptops ++ ["Redmi Note 9S"];
        };
        "prz5n-egjgc" = {
          label = "Shared Music";
          path = "/home/${user}/Music/shared-music";
          devices = laptops ++ ["Redmi Note 9S"];
        };
        "ewwca-actnr" = {
          label = "Shared Pics";
          path = "/home/${user}/Pictures/shared-pictures";
          devices = laptops;
        };
        "bjahe-fyok2" = {
          label = "Shared Videos";
          path = "/home/${user}/Videos/shared-videos";
          devices = laptops;
        };
        "uusn3-urfng" = {
          label = "Redmi Note 9S Camera";
          path = "/home/${user}/Pictures/redmi-note-9s-camera";
          devices = laptops ++ ["Redmi Note 9S"];
        };
        "mid9i-b3h7v" = {
          label = "Redmi Note 9S Screenshots";
          path = "/home/${user}/Pictures/redmi-note-9s-screenshots";
          devices = laptops ++ ["Redmi Note 9S"];
        };
        "hjshj-uh7fa" = {
          label = "Redmi Note 9S Movies";
          path = "/home/${user}/Videos/redmi-note-9s-movies";
          devices = laptops ++ ["Redmi Note 9S"];
        };
      };

      # Create a systemd unit for the syncthing service in the systemd system
      # instance, and auto launch it at system startup.
      # https://github.com/NixOS/nixpkgs/blob/d02d818f22c777aa4e854efc3242ec451e5d462a/nixos/modules/services/networking/syncthing.nix#L648
      systemService = true;
    };
  };
}
