{pkgs, ...}: {
  programs.atuin = {
    enable = true;
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
}
