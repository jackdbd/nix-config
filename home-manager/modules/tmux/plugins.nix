{
  fetchFromGitHub,
  lib,
  pkgs,
}: let
  # See how mkTmuxPlugin is used in nixpkgs
  # https://github.com/NixOS/nixpkgs/blob/master/pkgs/misc/tmux-plugins/default.nix
  inherit (pkgs.tmuxPlugins) mkTmuxPlugin continuum dracula resurrect;

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

  dracula-theme = {
    plugin = dracula;
    # https://draculatheme.com/tmux
    extraConfig = ''
      set -g @dracula-show-battery false
      set -g @dracula-show-powerline true
      set -g @dracula-refresh-rate 10
    '';
  };

  nord-theme = mkTmuxPlugin {
    pluginName = "nord";
    version = "v0.3.0";
    # https://github.com/nordtheme/tmux
    src = fetchFromGitHub {
      owner = "nordtheme";
      repo = "tmux";
      rev = "v0.3.0";
      sha256 = "sha256-s/rimJRGXzwY9zkOp9+2bAF1XCT9FcyZJ1zuHxOBsJM=";
    };
  };
in [
  aw-watcher-tmux
  dracula-theme
  # nord-theme
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
  {
    # Save the tmux environment every X minutes and automatically restore it
    plugin = continuum;
    extraConfig = ''
      set -g @continuum-restore 'on'
      set -g @continuum-save-interval '15' # in minutes
    '';
  }
]
