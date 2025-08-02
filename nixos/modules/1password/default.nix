{user, ...}: {
  meta = {};

  imports = [];

  options = {};

  config = {
    programs._1password = {
      enable = true; # Enable the 1Password CLI
    };

    programs._1password-gui = {
      enable = true; # Enable the 1Password desktop app

      # Certain 1Password features, including CLI integration and system
      # authentication support, require enabling PolKit integration on some
      # desktop environments.
      polkitPolicyOwners = [user];
    };
  };
}
