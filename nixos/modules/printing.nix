{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.services.printing;
in {
  imports = [];

  options = {};

  meta = {};

  # CUPS: configure and add network printers via http://localhost:631
  # https://nixos.wiki/wiki/Printing
  # https://github.com/NixOS/nixpkgs/tree/master/nixos/modules/services/printing
  # I have a Brother MFC-J6510DW
  # https://github.com/pdewacht/brlaser
  config.services.printing = mkIf cfg.enable {
    # https://nixos.wiki/wiki/Printing#Manually_supplying_printer_driver
    # pkgs.brgenml1lpr and pkgs.brgenml1cupswrapper — Generic drivers for more Brother printers
    drivers = [pkgs.brlaser];
  };

  # https://nixos.wiki/wiki/Printing#Enable_autodiscovery_of_network_printers
  config.services.avahi = mkIf cfg.enable {
    enable = true;
    nssmdns = true;
    openFirewall = true;
  };
}
