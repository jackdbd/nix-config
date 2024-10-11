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
        drawColor = "#000000";
        # "picker" adds a custom color picker
        userColors = "picker, #800000, #ff0000, #ffff00, #00ff00, #008000, #00ffff, #0000ff, #ff00ff, #800080";
        drawThickness = 6;
        uiColor = "#740096";
        savePath = "/home/${user}/Pictures";
      };
    };
  };
}
