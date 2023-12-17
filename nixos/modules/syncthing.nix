{
  config,
  lib,
  pkgs,
  user,
  ...
}:
with lib; let
  cfg = config.programs.syncthing-wrapper;
in {
  imports = [];

  # https://search.nixos.org/options?channel=23.11&from=0&size=50&sort=relevance&type=packages&query=syncthing
  options.programs.syncthing-wrapper = {
    guiAddress = mkOption {
      type = types.str;
      description = mdDoc ''
        The address of the Syncthing graphical user interface.
      '';
      default = "0.0.0.0:8384";
      example = "127.0.0.1:8384";
    };
  };

  config = {
    environment.systemPackages = with pkgs; [
      syncthing # peer-to-peer file synchronization
    ];

    services.syncthing = {
      inherit user;

      enable = true;
      configDir = "/home/${user}/.config/syncthing"; # Folder for Syncthing's settings and keys
      dataDir = "/home/${user}/Documents"; # Default folder for new synced folders

      devices = {
        "Redmi Note 9S" = {id = "7WJ47ZP-O776CHO-OELIPNH-GUOZHA4-UYYZ3WS-PL5BE6L-INDDN3D-FHKDDQQ";};
        "ThinkPad L380" = {id = "ENRVVVG-BKZ3LJH-ZHKXKPH-JW2HUF7-BNPWHFF-YDNPR2Z-UCNJBEL-T6C45AV";};
        "ThinkPad L390" = {id = "ZUVYNEP-4CMUUH5-6P75652-VYIEQLU-COK4UYC-4RUIO4F-7GAOYDE-BVDP7AM";};
        "ThinkPad X220" = {id = "WQ2BV2F-VOYX4RT-WBBI26I-U3KCTCV-JRGRQUZ-MNT44DV-COAMMYQ-JPF5EAN";};
      };
      # services.syncthing.settings.devices.<name>.autoAcceptFolders = true;

      # Consider using a secret for the Syncthing GUI. But how does a non-NixOS
      # host (e.g. a laptop running Xubuntu) decrypt this secret? I think I would
      # need to use the sops-nix Home Manager module, not the sops-nix NixOS module.
      # extraOptions.gui = {
      #   user = "username";
      #   password = "password";
      # };

      folders = {
        # Folder ID in Syncthing
        "mihyn-ggmuw" = {
          # Folder name in Syncthing
          label = "Shared Docs";
          # Which folder to add to Syncthing
          path = "/home/${user}/Documents/shared-documents";
          # Which devices to share the folder with
          devices = ["Redmi Note 9S" "ThinkPad L380" "ThinkPad L390" "ThinkPad X220"];
        };
        "prz5n-egjgc" = {
          label = "Shared Music";
          path = "/home/${user}/Music/shared-music";
          devices = ["Redmi Note 9S" "ThinkPad L380" "ThinkPad L390" "ThinkPad X220"];
        };
        "ewwca-actnr" = {
          label = "Shared Pics";
          path = "/home/${user}/Pictures/shared-pictures";
          devices = ["ThinkPad L380" "ThinkPad L390" "ThinkPad X220"];
        };
        "bjahe-fyok2" = {
          label = "Shared Videos";
          path = "/home/${user}/Videos/shared-videos";
          devices = ["ThinkPad L380" "ThinkPad L390" "ThinkPad X220"];
        };
        "mid9i-b3h7v" = {
          label = "Redmi Note 9S Screenshots";
          path = "/home/${user}/Pictures/redmi-note-9s-screenshots";
          devices = ["Redmi Note 9S" "ThinkPad L380" "ThinkPad L390" "ThinkPad X220"];
        };
      };

      guiAddress = cfg.guiAddress;

      overrideDevices = true; # overrides any devices added or deleted through the WebUI
      overrideFolders = true; # overrides any folders added or deleted through the WebUI
    };
  };

  meta = {};
}
