# Secrets for my AWS configuration profiles

Encrypted YAML files for my AWS secrets.

Create a YAML file for each [AWS profile](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files.html). Each file should have the following structure, with the AWS profile name (e.g. default) as its top-level key:

```yaml
aws:
    default: |
        {
            "access_key_id": "...",
            "secret_access_key": "..."
        }
```

## Decrypt a SOPS file

For example, here is how to decrypt the SOPS file containing the AWS `default` configuration profile:

```sh
sops secrets/aws/default.sops.yaml
```

## Retrieve the secret

In the NixOS module where we configure sops-nix we can set `sops.secrets."aws/default"`, and at runtime we can access the unencrypted secret with a command like this:

```sh
cat /run/secrets/aws/default
```
