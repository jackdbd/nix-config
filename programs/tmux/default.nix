{ lib, pkgs, ... }:

# Use // (i.e. update operator) to merge the Tmux plugins defined in Nixpkgs
# with the ones defined in custom-plugins.nix
# https://nixos.org/manual/nix/stable/language/operators#update
let
  plugins = pkgs.tmuxPlugins // pkgs.callPackage ./custom-plugins.nix { };
  tmuxExtraConfig = lib.readFile ./extra.conf;
in
{
  programs.tmux = {
    enable = true;
    # nice Tmux configurations:
    # https://gist.github.com/TheCedarPrince/07f6f8f79b1451ec436ff8dee236ccdd
    # https://github.com/jackdbd/dotfiles/blob/main/tmux/.config/tmux/tmux.conf
    # https://github.com/gvolpe/nix-config/tree/master/home/programs/tmux

    # https://nix-community.github.io/home-manager/options.html#opt-programs.tmux.aggressiveResize
    aggressiveResize = false;
    
    # set first window and pane to index 1 (not 0) to be more convenient for my keyboard layout
    baseIndex = 1;
    
    clock24 = false;
    escapeTime = 500;
    extraConfig = tmuxExtraConfig;
    keyMode = "emacs";
    mouse = false;

    # Run tmux-sensible plugin at the top of the tmux configuration. If you need
    # to customize this plugin, use programs.tmux.extraConfig.
    sensibleOnTop = true;
    # https://nix-community.github.io/home-manager/options.html#opt-programs.tmux.plugins
    # All plugins declared here are included at the end of the tmux configuration.
    # I guess Tmux Plugin Manager is always installed by Nix?
    plugins = with plugins; [
      nord # theme
      {
        plugin = resurrect;
        extraConfig = "set -g @resurrect-capture-pane-contents 'on'";
      }
      {
        plugin = continuum;
        extraConfig = ''
          set -g @continuum-restore 'on'
          set -g @continuum-save-interval '10' # in minutes
        '';
      }
    ];

    # prefix = "C-a";
    shortcut = "a";
    terminal = "screen-256color";
  };
}