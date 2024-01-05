# Secrets for my GCP projects

Encrypted YAML files for my GCP secrets.

Create a YAML file for each GCP project. Each file should have the following structure, with the GCP project ID as its top-level key:

```yaml
my-project:
  my-service-account: |
    {
        "type": "service_account",
        "project_id": "the GCP project ID",
        "private_key_id": "...",
        "...": "..."
    }
```

The reason to have the GCP project ID as the top-level key is that it allows us to create a "namespace" for the nested keys. In the NixOS module where we configure sops-nix we can set `sops.secrets."my-project/my-service-account"`, and at runtime we can access the unencrypted secret with a command like this:

```sh
cat /run/secrets/my-project/my-service-account
```

Encrypt the YAML file using SOPS.

```sh
sops --config secrets/.sops.yaml \
  --encrypt secrets/gcp/my-project.yaml > secrets/gcp/my-project.sops.yaml
```

Remove `my-project.yaml` (unencrypted file) and commit `my-project.sops.yaml` (encrypted file).
