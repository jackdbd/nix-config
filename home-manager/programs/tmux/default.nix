{
  lib,
  pkgs,
  ...
}:
# Use // (i.e. update operator) to merge the Tmux plugins defined in Nixpkgs
# with the ones defined in custom-plugins.nix
# https://nixos.org/manual/nix/stable/language/operators#update
let
  plugins = pkgs.tmuxPlugins // pkgs.callPackage ./custom-plugins.nix {};
  tmuxExtraConfig = lib.readFile ./extra.conf;
in {
  programs.tmux = {
    enable = true;

    # Set first window and pane to index 1 (not 0) to be more convenient for my keyboard layout
    baseIndex = 1;

    clock24 = false;
    escapeTime = 500;
    extraConfig = tmuxExtraConfig;
    keyMode = "emacs";

    # Include the tmux-sensible plugin at the top of the tmux configuration.
    # If you need to customize this plugin, use programs.tmux.extraConfig.
    sensibleOnTop = true;
    # https://nix-community.github.io/home-manager/options.html#opt-programs.tmux.plugins
    # All plugins declared here are included at the end of the tmux configuration.
    # I guess Tmux Plugin Manager is always installed by Nix?
    plugins = with plugins; [
      aw-watcher-tmux
      nord # theme
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
    ];

    shortcut = "a"; # This means that the Tmux prefix is set to C-a (i.e. Ctrl + a)
    terminal = "screen-256color";
  };
}
