# Secrets for my Cloudflare account

Encrypted YAML files for my Cloudflare secrets.

## Create a YAML file

Create a YAML file that has the following structure.

```yaml
cloudflare:
    r2: |
        {
            "access_key_id": "<value>",
            "secret_access_key": "<value>"
        }
    tokens: |
        {
            "dns_edit": "<value>"
        }
```

## Encrypt the YAML file using SOPS

Obviously, the YAML file should be encrypted before committing it to the repository.

```sh
sops --config secrets/.sops.yaml \
  --encrypt "secrets/cloudflare/default.yaml" > "secrets/cloudflare/default.sops.yaml"
```

## Remove the unencrypted YAML file

First, double check that you can decrypt the encrypted file using SOPS.

```sh
sops secrets/cloudflare/default.sops.yaml
```

Then, remove `cloudflare/default.yaml` (unencrypted file) and commit `cloudflare/default.sops.yaml` (encrypted file).

> [!IMPORTANT]  
> Donm't forget to update the [`secrets.nix`](../../nixos/modules/secrets.nix) NixOS module and the [`debug-secrets.nix`](../../nixos/scripts/debug-secrets.nix) script.
