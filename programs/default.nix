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

      feh.enable = true;

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