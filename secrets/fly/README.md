# Secrets for my Fly.io account

Encrypted YAML files for my Fly.io secrets.

## Create a YAML file

Create a YAML file that has the following structure.

```yaml
fly:
    tokens: |
        {
            "deploy": "<value>"
        }
```

## Encrypt the YAML file using SOPS

Obviously, the YAML file should be encrypted before committing it to the repository.

Update the `creation_rules` in [`.sops.yaml`](../.sops.yaml) and run this command:

```sh
sops --config secrets/.sops.yaml \
  --encrypt "secrets/fly/default.yaml" > "secrets/fly/default.sops.yaml"
```

## Remove the unencrypted YAML file

First, double check that you can decrypt the encrypted file using SOPS.

```sh
sops secrets/fly/default.sops.yaml
```

Then, remove `fly/default.yaml` (unencrypted file) and commit `fly/default.sops.yaml` (encrypted file).

> [!IMPORTANT]  
> Donm't forget to update the [`secrets.nix`](../../nixos/modules/secrets.nix) NixOS module and the [`debug-secrets.nix`](../../nixos/scripts/debug-secrets.nix) script.
