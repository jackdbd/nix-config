{
  fetchFromGitHub,
  lib,
  pkgs,
}: let
  # See how mkTmuxPlugin is used in nixpkgs
  # https://github.com/NixOS/nixpkgs/blob/master/pkgs/misc/tmux-plugins/default.nix
  inherit (pkgs.tmuxPlugins) mkTmuxPlugin catppuccin continuum dracula nord resurrect;

  aw-watcher-tmux = mkTmuxPlugin {
    pluginName = "aw-watcher-tmux";
    version = "latest";
    # https://github.com/akohlbecker/aw-watcher-tmux
    src = fetchFromGitHub {
      owner = "akohlbecker";
      repo = "aw-watcher-tmux";
      rev = "master";
      # sha256 = lib.fakeSha256;
      sha256 = "sha256-L6YLyEOmb+vdz6bJdB0m5gONPpBp2fV3i9PiLSNrZNM=";
    };
  };

  catppuccin-theme = {
    plugin = catppuccin;
    # https://github.com/catppuccin/tmux
    extraConfig = ''
      set -g @catppuccin_status_modules_right "application session user host date_time"
      set -g @catppuccin_date_time_text "%Y-%m-%d %H:%M:%S"
    '';
  };

  dracula-theme = {
    plugin = dracula;
    # https://draculatheme.com/tmux
    extraConfig = ''
      set -g @dracula-fixed-location "Hyrule"
      set -g @dracula-refresh-rate 10
      set -g @dracula-show-battery false
      set -g @dracula-show-fahrenheit false
      set -g @dracula-show-powerline true
    '';
  };

  nord-theme = {
    plugin = nord;
    # https://github.com/nordtheme/tmux
    # https://www.nordtheme.com/docs/ports/tmux/configuration
    extraConfig = ''
      set -g @nord_tmux_date_format "%Y-%m-%d %H:%M"
    '';
  };
in [
  aw-watcher-tmux
  # catppuccin-theme
  # dracula-theme
  nord-theme
  {
    # Save/restore the tmux environment
    # save:    prefix + C-s
    # restore: prefix + C-r
    plugin = resurrect;
    extraConfig = ''
      set -g @resurrect-capture-pane-contents 'on'
      set -g @resurrect-pane-contents-area 'full'
    '';
  }
  # temporarily disable continuum to try out tmux themes.
  # {
  #   # Save the tmux environment every X minutes and automatically restore it
  #   plugin = continuum;
  #   extraConfig = ''
  #     set -g @continuum-restore 'on'
  #     set -g @continuum-save-interval '15' # in minutes
  #   '';
  # }
]
