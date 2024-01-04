let
  more = {
    lib,
    pkgs,
    ...
  }: {
    programs = {
      bat.enable = true;

      broot.enable = true;

      htop.enable = true;

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
  ./bash.nix
  ./feh.nix
  ./neovim
  ./rofi.nix
  ./zathura.nix
  more
]
