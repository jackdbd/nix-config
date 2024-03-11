{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.services.trezord;
in {
  meta = {};

  imports = [];

  options = {
    services.trezord = {
      # already declared here:
      # https://github.com/NixOS/nixpkgs/blob/master/nixos/modules/services/hardware/trezord.nix
      # This will add all necessary udev rules and start Trezor Bridge.
      # enable = mkEnableOption "Enable Trezor Bridge (daemon for the Trezor hardware wallet)";
    };
  };

  # https://nixos.org/manual/nixos/stable/#trezor
  # https://mynixos.com/nixpkgs/package/trezord
  # https://docs.trezor.io/trezor-user-env/development.html
  config = mkIf cfg.enable {
    environment.systemPackages = [pkgs.trezord];
  };
}
