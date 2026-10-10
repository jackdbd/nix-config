{ pkgs, ... }: {
  programs.rofi = {
    enable = true;

    # https://nix-community.github.io/home-manager/options.html#opt-programs.rofi.plugins
    plugins = [
      # pkgs.rofi-calc
      # pkgs.rofi-top
    ];

    settings = {
      font = "JetBrainsMono Nerd Font 14";
      icon-theme = "Papirus";
      show-icons = true;
    };

    # Available named themes can be viewed using the rofi-theme-selector tool.
    theme = "gruvbox-dark";
  };
}
