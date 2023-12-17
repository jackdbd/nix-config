{
  config,
  pkgs,
  ...
}: {
  # https://github.com/iAmMrinal0/nix-config/blob/master/config/zathura.nix
  # https://mipmip.github.io/home-manager-option-search/?query=zathura
  # https://github.com/iAmMrinal0/nix-config/blob/master/config/zathura.nix
  programs.zathura = {
    enable = true;
    extraConfig = ''
      set font  "JetBrainsMono Nerd Font 14"

      # keybindings
      map [fullscreen] a adjust_window best-fit
      map [fullscreen] s adjust_window width
      map [fullscreen] f follow
      map [fullscreen] <Tab> toggle_index
      map [fullscreen] j scroll down
      map [fullscreen] k scroll up
      map [fullscreen] h navigate previous
      map [fullscreen] l navigate next
    '';
  };
}
