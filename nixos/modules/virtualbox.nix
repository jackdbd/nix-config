{
  config,
  lib,
  pkgs,
  ...
}: {
  # https://nixos.wiki/wiki/VirtualBox
  meta = {};

  imports = [];

  options = {};

  config = {
    virtualisation.virtualbox.host.enable = true;
    users.extraGroups.vboxusers.members = ["jack"];
  };
}
