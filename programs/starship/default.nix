{ lib, ... }:

{
  programs.starship = {
    enable = true;
    enableBashIntegration = true;
    
    # https://starship.rs/config/#prompt
    settings = {
      add_newline = true;
      # https://starship.rs/config/#default-prompt-format
      format = lib.concatStrings [
        "$all"
      ];
      # https://starship.rs/config/#google-cloud-gcloud
      gcloud.disabled = true;
      jobs.disabled = true;
      os.disabled = true;
    };
  };
}