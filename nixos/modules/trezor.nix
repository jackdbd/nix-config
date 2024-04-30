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
    environment.systemPackages = with pkgs; [
      trezord
      trezor_agent # hardware-based SSH/GPG/age agent
    ];

    environment.sessionVariables = {
      # This tells the trezor-agent that all private keys (e.g. GPG, SSH, age)
      # are backed by my Trezor. Unset this environment variable if you wish to
      # switch back to your software keys.
      # https://github.com/romanz/trezor-agent/blob/master/doc/README-GPG.md
      GNUPGHOME = "~/.gnupg/trezor";
    };
  };
}
