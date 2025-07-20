{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.programs.starship;
in {
  meta = {};

  imports = [];

  options = {
    programs.starship = {
      # already declared in home-manager/modules/starship.nix
      # enable = mkEnableOption "Install starship (customizable prompt for any shell)";
    };
  };

  config = mkIf cfg.enable {
    home.packages = [cfg.package];

    programs.starship = {
      enableBashIntegration = true;

      # https://starship.rs/config/#prompt
      settings = {
        add_newline = true; # add a blank line between shell prompts
        # https://starship.rs/config/#aws
        aws.disabled = true;
        # https://starship.rs/config/#default-prompt-format
        format = concatStrings [
          "$all"
        ];
        # https://starship.rs/config/#google-cloud-gcloud
        gcloud.disabled = true;
        jobs.disabled = true;
        line_break.disabled = true; # make the shell prompt a single line
        os.disabled = true;
      };
    };
  };
}
