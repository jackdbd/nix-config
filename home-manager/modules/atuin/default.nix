{
  config,
  fetchFromGitHub,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.programs.atuin;
in {
  meta = {};

  options = {
    programs.atuin = {
      # already declared in home-manager/modules/atuin
      # enable = mkEnableOption "Enable atuin";
    };
  };

  config = mkIf cfg.enable {
    home.packages = [cfg.package];

    programs.atuin = {
      enableBashIntegration = true;
      flags = [
        "--disable-up-arrow"
      ];
      # https://atuin.sh/docs/config
      settings = {
        enter_accept = true;
        search_mode = "fuzzy";
        style = "full";
        sync_address = "https://api.atuin.sh";
      };
    };
  };
}
