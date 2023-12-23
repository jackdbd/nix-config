{
  fetchFromGitHub,
  lib,
  pkgs,
  ...
}:
# See how mkTmuxPlugin is used in nixpkgs
# https://github.com/NixOS/nixpkgs/blob/master/pkgs/misc/tmux-plugins/default.nix
let
  buildTmuxPlugin = pkgs.tmuxPlugins.mkTmuxPlugin;
in {
  aw-watcher-tmux = buildTmuxPlugin {
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
  nord = buildTmuxPlugin {
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
}
