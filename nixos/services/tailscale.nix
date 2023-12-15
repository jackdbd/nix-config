{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [];

  options = {};

  # https://nixos.wiki/wiki/Tailscale
  # https://tailscale.com/blog/nixos-minecraft/
  # https://mynixos.com/nixpkgs/options/services.tailscale
  config = {
    services.tailscale = {
      enable = true;
      # introduced in NixOS 23.11
      extraUpFlags = ["--ssh"];
    };
  };

  meta = {};
}
