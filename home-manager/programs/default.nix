let
  more = {
    lib,
    pkgs,
    ...
  }: {
    programs = {
      bat = {
        enable = true;
        config = {
          # https://github.com/sharkdp/bat?tab=readme-ov-file#customization
          # theme = "Dracula";
          theme = "Monokai Extended Origin";
          # theme = "TwoDark";
        };
      };

      broot.enable = true;

      btop = {
        enable = true;
        settings = {
          color_theme = "Default";
        };
      };

      htop = {
        enable = true;
        settings = {
          color_scheme = 6;
        };
      };

      tealdeer = {
        enable = true;
        # https://nix-community.github.io/home-manager/options.html#opt-programs.tealdeer.settings
        # https://dbrgn.github.io/tealdeer/config.html
        settings = {};
      };

      vim.enable = true;

      # https://mipmip.github.io/home-manager-option-search/?query=zoxide
      zoxide = {
        enable = true;
        enableBashIntegration = true;
      };
    };
  };
in [
  ./alacritty.nix
  ./feh.nix
  ./neovim
  ./rofi.nix
  ./zathura.nix
  more
]
