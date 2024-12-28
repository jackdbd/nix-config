{pkgs, ...}: {
  programs.alacritty = {
    enable = true;

    # https://nix-community.github.io/home-manager/options.html#opt-programs.alacritty.settings
    # https://github.com/alacritty/alacritty/tree/master#configuration
    settings = {
      colors = {
        primary = {
          background = "0x282a36";
          foreground = "0xeff0eb";
        };
        normal = {
          black = "0x282a36";
          red = "0xff5c57";
          green = "0x5af78e";
          yellow = "0xf3f99d";
          blue = "0x57c7ff";
          magenta = "0xff6ac1";
          cyan = "0x9aedfe";
          white = "0xf1f1f0";
        };
        bright = {
          black = "0x686868";
          red = "0xff5c57";
          green = "0x5af78e";
          yellow = "0xf3f99d";
          blue = "0x57c7ff";
          magenta = "0xff6ac1";
          cyan = "0x9aedfe";
          white = "0xf1f1f0";
        };
      };
      font = {
        normal = {
          family = "JetBrainsMono Nerd Font";
          style = "Regular";
        };
        size = 11.0;
      };
      scrolling.history = 10000;
      selection.save_to_clipboard = true;
      window = {
        decorations = "none";
        dynamic_padding = true;
        opacity = 0.95;
        padding = {
          x = 5;
          y = 5;
        };
        startup_mode = "Maximized";
      };
    };
  };
}
