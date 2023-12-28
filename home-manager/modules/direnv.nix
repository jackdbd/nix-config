{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.programs.direnv;
in {
  meta = {};

  imports = [];

  options = {
    programs.direnv = {
      # already declared in home-manager/modules/direnv.nix
      # enable = mkEnableOption "Install direnv";
    };
  };

  config = mkIf cfg.enable {
    home.packages = [cfg.package];

    programs.direnv = {
      # https://direnv.net/man/direnv.toml.1.html
      config = {
        global = {
          strict_env = true;
        };
      };
      enableBashIntegration = true;
      # use nix-direnv instead of the "vanilla" direnv
      # https://github.com/nix-community/nix-direnv?tab=readme-ov-file#via-home-manager
      nix-direnv.enable = true;
    };
  };
}
