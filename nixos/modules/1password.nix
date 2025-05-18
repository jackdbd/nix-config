{
  config,
  lib,
  pkgs,
  user,
  ...
}: {
  meta = {};

  imports = [];

  options = {};

  config = {
    # https://developer.1password.com/docs/cli/get-started/
    # https://nixos.wiki/wiki/1Password
    programs._1password = {
      enable = true; # Enable the 1Password CLI
    };

    programs._1password-gui = {
      enable = true; # Enable the 1Password desktop app
      # this makes system auth etc. work properly
      polkitPolicyOwners = [user];
    };
  };
}
