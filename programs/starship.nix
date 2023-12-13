{ lib, ... }:

{
  programs.starship = {
    enable = true;
    enableBashIntegration = true;
    
    # https://starship.rs/config/#prompt
    settings = {
      add_newline = true; # add a blank line between shell prompts
      # https://starship.rs/config/#default-prompt-format
      format = lib.concatStrings [
        "$all"
      ];
      # https://starship.rs/config/#google-cloud-gcloud
      gcloud.disabled = true;
      jobs.disabled = true;
      line_break.disabled = true; # make the shell prompt a single line
      os.disabled = true;
    };
  };
}