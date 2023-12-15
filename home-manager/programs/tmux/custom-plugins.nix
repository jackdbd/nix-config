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
  revision = "v0.3.0";
in {
  nord = buildTmuxPlugin {
    pluginName = "nord";
    version = revision;
    # https://github.com/nordtheme/tmux
    src = fetchFromGitHub {
      owner = "nordtheme";
      repo = "tmux";
      rev = revision;
      # sha256 = lib.fakeSha256;
      sha256 = "sha256-s/rimJRGXzwY9zkOp9+2bAF1XCT9FcyZJ1zuHxOBsJM=";
    };
  };
}
