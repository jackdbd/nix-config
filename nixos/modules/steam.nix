{
  config,
  lib,
  pkgs,
  ...
}: {
  # https://nixos.wiki/wiki/Steam
  meta = {};

  imports = [];

  options = {};

  config = {
    programs.steam = {
      enable = true;
      dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
      # gamescopeSession.enable = true;
      localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
      remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    };
  };
}
