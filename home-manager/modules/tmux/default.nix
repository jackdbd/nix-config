{
  config,
  fetchFromGitHub,
  lib,
  pkgs,
  ...
}:
# Use // (i.e. update operator) to merge the Tmux plugins defined in Nixpkgs
# with the ones defined in custom-plugins.nix
# https://nixos.org/manual/nix/stable/language/operators#update
with lib; let
  cfg = config.programs.tmux;
in {
  meta = {};

  options = {
    programs.tmux = {
      # already declared in home-manager/modules/tmux
      # enable = mkEnableOption "Tmux";

      # already declared in home-manager/modules/tmux
      # package = mkOption {
      #   type = types.package;
      #   default = pkgs.tmux;
      #   defaultText = literalExpression "pkgs.tmux";
      #   description = "Package providing tmux.";
      # };
    };
  };

  config = mkIf cfg.enable {
    home.packages = [
      cfg.package
      # pkgs.tmuxPlugins.continuum
      # pkgs.tmuxPlugins.resurrect
    ];

    programs.tmux = {
      # Set first window and pane to index 1 (not 0) to be more convenient for my keyboard layout
      baseIndex = 1;

      clock24 = false;
      escapeTime = 500;
      extraConfig = readFile ./extra.conf;
      keyMode = "emacs";

      # I guess Tmux Plugin Manager is always installed by Nix?
      # https://nix-community.github.io/home-manager/options.html#opt-programs.tmux.plugins

      # Include the tmux-sensible plugin at the top of the tmux configuration.
      # If you need to customize this plugin, use programs.tmux.extraConfig.
      # If you need to customize any other plugin, use extraConfig in the plugin itself.
      sensibleOnTop = true;
      plugins = pkgs.callPackage ./plugins.nix {};

      shortcut = "a"; # This means that the Tmux prefix is set to C-a (i.e. Ctrl + a)
      terminal = "screen-256color";
    };
  };
}
