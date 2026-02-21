{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.services.printing;
in
{
  meta = { };

  imports = [ ];

  options = {
    services.printing = {
      # already declared in nixos/modules/services/printing/cupsd.nix
      # enable = mkEnableOption "Whether to enable printing support through the CUPS daemon.";
    };
  };

  # CUPS: configure and add network printers via http://localhost:631
  # https://nixos.wiki/wiki/Printing
  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      brscan4
    ];

    hardware.sane.enable = true;
    hardware.sane.extraBackends = with pkgs; [
      brscan4
      sane-airscan
    ];
    hardware.sane.brscan4.enable = true;
    hardware.sane.brscan4.netDevices = {
      # "Brother_HL_L2445DW" = {
      #   model = "HL-L2445DW";
      #   # IP reserved in TP-Link Deco app > More > Advanced > Address Reservation
      #   ip = "192.168.68.55";
      # };
    };

    # https://nixos.wiki/wiki/Printing#Enable_autodiscovery_of_network_printers
    services.avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };

    # https://github.com/NixOS/nixpkgs/tree/master/nixos/modules/services/printing
    # https://nixos.wiki/wiki/Printing#Manually_supplying_printer_driver
    services.printing = {
      drivers = with pkgs; [
        # CUPS driver for Brother laser printers
        # https://github.com/pdewacht/brlaser
        brlaser

        ghostscript

        # huge database of drivers for inkjet printers
        gutenprint
      ];
    };

  };
}
