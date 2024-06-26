{
  config,
  pkgs,
  ...
}: {
  # https://mipmip.github.io/home-manager-option-search/?query=zathura
  # https://manpages.ubuntu.com/manpages/jammy/man5/zathurarc.5.html
  programs.zathura = {
    enable = true;
    # Use `man zathurarc` to see all configuration options
    # Configuration examples:
    # - https://gist.github.com/michaelmrose/9595075b43f24aa903fa
    # - https://github.com/iAmMrinal0/nix-config/blob/master/config/zathura.nix
    options = {
      # Open document in fit-width mode by default
      adjust-open = "best-fit";
      default-bg = "#000000";
      default-fg = "#F7F7F6";
      font = "FiraCode Nerd Font 15";
      page-padding = 10;
      pages-per-row = 1;

      # stop at page boundaries
      scroll-page-aware = true;

      # Defines the X clipboard into which mouse-selected data will be written.
      # When it is "clipboard",  selected  data will be written to the CLIPBOARD
      # clipboard, and can be pasted using the Ctrl+v key combination.
      # When it is "primary", selected data  will be  written  to  the  PRIMARY
      # clipboard, and can be pasted using the middle mouse button, or the
      # Shift-Insert key combination.
      selection-clipboard = "clipboard";
    };
    # keybindings
    mappings = {
      "<Tab>" = "toggle_index";
      f = "toggle_fullscreen";
      "[fullscreen] f" = "toggle_fullscreen";
      "[fullscreen] h" = "navigate previous";
      "[fullscreen] j" = "scroll down";
      "[fullscreen] k" = "scroll up";
      "[fullscreen] l" = "navigate next";
      "[fullscreen] s" = "adjust_window width";
    };
    extraConfig = ''
      # set font  "JetBrainsMono Nerd Font 14"

      map [fullscreen] a adjust_window best-fit
    '';
  };
}
