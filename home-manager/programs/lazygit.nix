{
  config,
  pkgs,
  ...
}: {
  programs.lazygit = {
    enable = true;
    # https://rycee.gitlab.io/home-manager/options.html#opt-programs.lazygit.settings
    # https://github.com/jesseduffield/lazygit/blob/master/docs/Config.md
    settings = {
      gui = {
        nerdFontsVersion = "3";
        windowSize = "half"; # "normal" (default) | "half" | "full"
      };
    };
  };
}
