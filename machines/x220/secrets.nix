{ config, sops, ... }:


let
  # Either a user id or group name representation of the secret owner
  # It is recommended to get the user name from `config.users.users.<?name>.name` to avoid misconfiguration
  owner = config.users.users.jack.name;
  
  # Either the group id or group name representation of the secret group
  # It is recommended to get the group name from `config.users.users.<?name>.group` to avoid misconfiguration
  group = config.users.users.jack.group;

  # Permission modes are in octal representation (same as chmod),
  # the digits represent: user|group|owner
  # 7 - full (rwx)
  # 6 - read and write (rw-)
  # 5 - read and execute (r-x)
  # 4 - read only (r--)
  # 3 - write and execute (-wx)
  # 2 - write only (-w-)
  # 1 - execute only (--x)
  # 0 - none (---)
  permissions = "0440";
in
{
  imports = [
    <sops-nix/modules/sops> # nix-channel
    # inputs.sops-nix.nixosModules.sops # nix flake
  ];

  # https://github.com/Mic92/sops-nix?tab=readme-ov-file#deploy-example
  sops.defaultSopsFile = ../../secrets/secrets.yaml;
  sops.defaultSopsFormat = "yaml";
  # This will be at /run/secrets.d/age-keys.txt
  # sudo ls -la /run/secrets.d/
  sops.age.keyFile = "/home/jack/.config/sops/age/keys.txt";

  # This secret will be at /run/secrets/github_token_workflow_developer
  # sudo ls -la /run/secrets.d/1
  sops.secrets.github_token_workflow_developer = {
    owner = owner;
    group = group;
    mode = permissions;
  };

  sops.secrets."nested_secret/npm_token_read_all_packages" = {
    owner = owner;
    group = group;
    mode = permissions;
  };

  sops.secrets."abc/def/ghi/deeply-nested" = {
    owner = owner;
    group = group;
    mode = permissions;
  };
}