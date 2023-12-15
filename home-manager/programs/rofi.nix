{pkgs, ...}: {
  programs.rofi = {
    enable = true;
    # https://nix-community.github.io/home-manager/options.html#opt-programs.rofi.extraConfig
    extraConfig = {
      icon-theme = "Papirus";
      # modi = "calc,drun,run,top";
      show-icons = true;
    };
    font = "JetBrainsMono Nerd Font 14";

    # https://nix-community.github.io/home-manager/options.html#opt-programs.rofi.plugins
    plugins = [
      # pkgs.rofi-calc
      # pkgs.rofi-top
    ];

    # Available named themes can be viewed using the rofi-theme-selector tool.
    theme = "gruvbox-dark";
  };
}
