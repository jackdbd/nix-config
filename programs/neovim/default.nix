{ config, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    # https://nix-community.github.io/home-manager/options.html#opt-programs.neovim.enable
  };
}