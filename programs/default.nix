let
  more = { lib, pkgs, ... }: {
    programs = {
      bat.enable = true;

      broot.enable = true;

      direnv = {
        enable = true;
        # https://nix-community.github.io/home-manager/options.html#opt-programs.direnv.config
        # https://direnv.net/man/direnv.toml.1.html
        config = {
          global = {
            strict_env = true;
          };
        };
        enableBashIntegration = true; # see note on other shells below
        # https://github.com/nix-community/nix-direnv
        nix-direnv.enable = true;
      };

      feh = {
        enable = true;
        keybindings = {
          zoom_in = "plus";
          zoom_out = "minus";

          scroll_up = "k Up";
          scroll_down = "j Down";
          scroll_right = "l Right";
          scroll_left = "h Left";

          delete = "D";
          next_img = "j l Right";
          prev_img = "k h Left";
          remove = "d Delete";
          render = "m";
          toggle_filenames = "I";
          toggle_info = "i";
          zoom_default = "0";
          zoom_fit = "C-0";

          toggle_fullscreen = "f";
          save_filelist = "F";
        };
      };

      htop.enable = true;

      lazygit = {
        enable = true;
        # https://nix-community.github.io/home-manager/options.html#opt-programs.lazygit.settings
        settings = {};
      };

      tealdeer = {
        enable = true;
        # https://nix-community.github.io/home-manager/options.html#opt-programs.tealdeer.settings
        # https://dbrgn.github.io/tealdeer/config.html
        settings = {};
      };

      vim.enable = true;

      # https://github.com/iAmMrinal0/nix-config/blob/master/config/zathura.nix
      zathura.enable = true;

      zoxide.enable = true;
    };
  };
in
[
  ./alacritty
  ./atuin
  ./bash
  ./chromium
  ./git
  ./neovim
  ./rofi
  ./starship
  ./tmux
  ./vscode
  more
]