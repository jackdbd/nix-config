{
  config,
  pkgs,
  user,
  ...
}: {
  meta = {};

  imports = [];

  options = {};

  config.home.packages = [
    pkgs.liferea # RSS reader
  ];

  config.home.file = {
    "${config.xdg.configHome}/liferea/feedlist.opml".source = ../../dotfiles/liferea/feedlist.opml;
  };
}
