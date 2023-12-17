{
  config,
  pkgs,
  user,
  ...
}: {
  meta = {};

  imports = [];

  options = {};

  config.home.packages = [
    pkgs.flameshot # screenshot tool
  ];

  config.services.flameshot = {
    enable = true;
    # https://github.com/flameshot-org/flameshot/blob/master/flameshot.example.ini
    # https://nix-community.github.io/home-manager/options.html#opt-services.flameshot.settings
    settings = {
      General = {
        checkForUpdates = true;
        drawColor = "#000000";
        drawThickness = 6;
        uiColor = "#740096";
        savePath = "/home/${user}/Pictures";
      };
    };
  };
}
