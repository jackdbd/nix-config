{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.programs.rssguard;
  iniFormat = pkgs.formats.ini {};
  tomlFormat = pkgs.formats.toml {};
in {
  meta = {};

  options = {
    programs.rssguard = {
      enable = mkEnableOption "Enable RSS Guard (RSS/Atom feed reader and podcast player)";

      package = mkOption {
        type = types.package;
        default = pkgs.rssguard;
        defaultText = literalExpression "pkgs.rssguard";
        description = "Package providing RSS Guard.";
      };
    };
  };

  config = mkIf cfg.enable {
    home.packages = [cfg.package];

    # ~/.config/RSS Guard 4/config/config.ini
    xdg.configFile."RSS Guard 4/config/config.ini".source = let
      # config = builtins.readFile ./config.ini;
      config = {
        feeds = {
          show_tree_branches = true;
        };
        gui = {
          default_sort_column_feeds = 0;
          default_sort_order_feeds = 0;
          enable_list_headers = true;
          enable_status_bar = true;
          enable_toolbars = true;
          main_menu_visible = true;
          # splitter_feeds=245, 1116
          # splitter_messages_vertical=121, 477
          start_in_fullscreen = false;
          window_is_maximized = true;
        };
        main = {
          first_run = false;
        };
        messages = {
          enable_message_preview = true;
        };
      };
    in
      iniFormat.generate "config.ini" config;

    # xdg.configFile."RSS Guard 4/config/config.toml".source = let
    #   config = builtins.readFile ./config.toml;
    # in
    #   tomlFormat.generate "config.toml" config;
  };
}
