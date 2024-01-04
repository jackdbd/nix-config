{
  config,
  sops-nix,
  user,
  ...
}: let
  # The secret's owner. It can be either a user ID or a username.
  # To avoid misconfiguration, prefer using `config.users.users.<?name>.name`
  # instead of hardcoding it.
  owner = config.users.users.${user}.name;

  # The secret's group. It can be either a group ID or a group name.
  # To avoid misconfiguration, prefer using `config.users.users.<?name>.group`
  # instead of hardcoding it.
  group = config.users.users.${user}.group;

  # Permission modes are in octal representation (same as chmod).
  # The digits represent: user|group|owner
  # 7 - full (rwx)
  # 6 - read and write (rw-)
  # 5 - read and execute (r-x)
  # 4 - read only (r--)
  # 3 - write and execute (-wx)
  # 2 - write only (-w-)
  # 1 - execute only (--x)
  # 0 - none (---)
  mode = "0400";
in {
  meta = {};

  imports = [
    sops-nix.nixosModules.sops
  ];

  options = {};

  config = {
    # The sops module of sops-nix has these configuration options:
    # https://github.com/Mic92/sops-nix/blob/master/modules/sops/default.nix

    # https://github.com/Mic92/sops-nix?tab=readme-ov-file#deploy-example
    sops.defaultSopsFile = ../../sops/secrets.yaml;
    sops.defaultSopsFormat = "yaml";
    # This will be at /run/secrets.d/age-keys.txt
    # sudo ls -la /run/secrets.d/
    sops.age.keyFile = "/home/${user}/.config/sops/age/keys.txt";

    # sops-nix does not allow string interpolation in a secret's identifier,
    # since it would be a security concern. TODO: add link as a reference.

    # This secret will be at /run/secrets/github_token_workflow_developer
    # sudo ls -la /run/secrets.d/1
    sops.secrets.github_token_workflow_developer = {
      inherit group mode owner;
    };

    sops.secrets."nested_secret/npm_token_read_all_packages" = {
      inherit group mode owner;
    };

    sops.secrets."gcp/prj-kitchen-sink/sa-storage-uploader" = {
      inherit group mode owner;
    };

    sops.secrets."reddit/trusted_client" = {
      inherit group mode owner;
    };

    sops.secrets."telegram/personal_bot" = {
      inherit group mode owner;
    };
  };
}
