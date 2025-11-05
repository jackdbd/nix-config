{pkgs, ...}: {
  meta = {};

  imports = [];

  options = {};

  config = {
    environment.systemPackages = with pkgs; [
      displaylink
    ];
    services.xserver = {
      videoDrivers = ["displaylink" "modesetting"];
    };
  };
}
