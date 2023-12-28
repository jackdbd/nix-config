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
  ./atuin.nix
  ./bash.nix
  ./feh.nix
  ./git.nix
  ./lazygit.nix
  ./neovim
  ./rofi.nix
  ./starship.nix
  ./zathura.nix
  more
]
