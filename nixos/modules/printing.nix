{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.services.printing;
in {
  meta = {};

  imports = [];

  options = {
    services.printing = {
      # already declared in nixos/modules/services/printing/cupsd.nix
      # enable = mkEnableOption "Whether to enable printing support through the CUPS daemon.";
    };
  };

  # CUPS: configure and add network printers via http://localhost:631
  # https://nixos.wiki/wiki/Printing
  config = mkIf cfg.enable {
    # https://nixos.wiki/wiki/Printing#Enable_autodiscovery_of_network_printers
    services.avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };

    # https://github.com/NixOS/nixpkgs/tree/master/nixos/modules/services/printing
    # I have a Brother MFC-J6510DW
    services.printing = {
      # https://nixos.wiki/wiki/Printing#Manually_supplying_printer_driver
      # pkgs.brgenml1lpr and pkgs.brgenml1cupswrapper — Generic drivers for more Brother printers
      # https://github.com/pdewacht/brlaser
      drivers = [pkgs.brlaser];
    };
  };
}
