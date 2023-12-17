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

      # https://github.com/iAmMrinal0/nix-config/blob/master/config/zathura.nix
      zathura.enable = true;

      zoxide.enable = true;
    };
  };
in [
  ./alacritty.nix
  ./atuin.nix
  ./bash.nix
  ./direnv.nix
  ./feh.nix
  ./git.nix
  ./lazygit.nix
  ./neovim
  ./rofi.nix
  ./starship.nix
  ./tmux
  ./vscode.nix
  more
]
