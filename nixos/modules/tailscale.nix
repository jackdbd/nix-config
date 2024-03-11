{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.services.tailscale;
in {
  meta = {};

  imports = [];

  options = {
    services.tailscale = {
      # already declared in nixos/modules/services/networking/tailscale.nix
      # enable = mkEnableOption "Enable Tailscale (mesh VPN built on WireGuard)";
    };
  };

  # https://nixos.wiki/wiki/Tailscale
  # https://tailscale.com/blog/nixos-minecraft/
  # https://mynixos.com/nixpkgs/options/services.tailscale
  config = mkIf cfg.enable {
    environment.systemPackages = [cfg.package];

    services.tailscale = {
      # introduced in NixOS 23.11
      extraUpFlags = ["--ssh"];
    };
  };
}
