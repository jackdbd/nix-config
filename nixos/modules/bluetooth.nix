{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.hardware.bluetooth;
in {
  meta = {};

  imports = [];

  options = {
    hardware.bluetooth = {
      # already declared in nixos/modules/bluetooth.nix
      # enable = mkEnableOption "Whether to enable support for Bluetooth.";
    };
  };

  config = mkIf cfg.enable {
    # Bluetooth configuration for PipeWire
    # https://nixos.wiki/wiki/PipeWire#Bluetooth_Configuration
    environment.etc = mkIf config.services.pipewire.enable {
      "wireplumber/bluetooth.lua.d/51-bluez-config.lua".text = ''
          bluez_monitor.properties = {
         ["bluez5.enable-sbc-xq"] = true,
         ["bluez5.enable-msbc"] = true,
         ["bluez5.enable-hw-volume"] = true,
         ["bluez5.headset-roles"] = "[ hsp_hs hsp_ag hfp_hf hfp_ag ]"
        }
      '';
    };

    environment.systemPackages = with pkgs; [
      bluez # bluetooth support for Linux
    ];

    # https://nixos.wiki/wiki/Bluetooth
    # https://github.com/NixOS/nixpkgs/issues/170573
    hardware.bluetooth = {
      # package = pkgs.bluez; # on Linux, BlueZ is the default bluetooth stack
      powerOnBoot = true; # powers up the default Bluetooth controller on boot
      # Set configuration for system-wide bluetooth (/etc/bluetooth/main.conf)
      settings = {
        General = {
          ControllerMode = "dual";
          # The --experimental flag enables experimental D-Bus interfaces
          # https://github.com/balsoft/nixos-config/blob/master/profiles/bluetooth.nix
          Experimental = true;
        };
        Policy = {
          AutoEnable = true;
        };
      };
    };

    # Configure the bluetooth.service systemd unit file overriding some of its fields
    systemd.services.bluetooth = {
      # The NixOS documentation seems to suggest we MUST specifiy overrideStrategy
      # if we want to use systemd template units.
      # The "asDropin" overrideStrategy creates a drop-in file named overrides.conf.
      overrideStrategy = "asDropin";

      # We add some links to ensure that we are actually overriding the [Unit]
      # section of the generated systemd unit file.
      unitConfig.Documentation = [
        "https://bluez-cheat-sheet.readthedocs.io/en/latest/"
        "https://github.com/NixOS/nixpkgs/issues/63703"
        "https://nixos.wiki/wiki/Bluetooth"
      ];

      # The --experimental flag enables experimental D-Bus interfaces
      # https://github.com/balsoft/nixos-config/blob/master/profiles/bluetooth.nix
      serviceConfig.ExecStart = lib.mkForce [
        ""
        "${pkgs.bluez}/libexec/bluetooth/bluetoothd -f /etc/bluetooth/main.conf --debug --experimental"
      ];
    };

    # For the Blueman applet to work, the blueman service must be enabled system-wide.
    # https://nixos.wiki/wiki/Bluetooth#Pairing_Bluetooth_devices
    services.blueman.enable = true;
  };
}
