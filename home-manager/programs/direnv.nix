{
  config,
  pkgs,
  ...
}: {
  programs.direnv = {
    enable = true;
    # https://nix-community.github.io/home-manager/options.html#opt-programs.direnv.config
    # https://direnv.net/man/direnv.toml.1.html
    config = {
      global = {
        strict_env = true;
      };
    };
    enableBashIntegration = true; # see note on other shells below
    # https://github.com/nix-community/nix-direnv
    nix-direnv.enable = true;
  };
}
