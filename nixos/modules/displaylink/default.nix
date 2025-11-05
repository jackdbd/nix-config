{
  config,
  lib,
  pkgs,
  ...
}: {
  meta = {};

  imports = [];

  options = {};

  config = {
    boot = {
      extraModulePackages = [config.boot.kernelPackages.evdi];
      initrd.kernelModules = ["evdi"];
    };

    environment.systemPackages = with pkgs; [
      displaylink
    ];

    services.xserver = {
      displayManager.sessionCommands = ''
        ${lib.getBin pkgs.xorg.xrandr}/bin/xrandr --setprovideroutputsource 2 0
      '';
      videoDrivers = ["displaylink" "modesetting"];
    };

    # Enable the DisplayLink Manager Service
    # The service name might vary, 'dlm' or 'displaylink-server' are common.
    # Check the NixOS wiki for the exact name in your version.
    # Using 'dlm' is a common choice for the provided NixOS package.
    systemd.services.dlm.wantedBy = ["multi-user.target"];
    # OR for the server name:
    # systemd.services.displaylink-server.wantedBy = [ "multi-user.target" ];
  };
}
