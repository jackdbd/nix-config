# Secrets for my GCP projects

Encrypted YAML files for my GCP secrets.

## Create one YAML file for each GCP project

Each YAML file should have the following structure, with the GCP project ID as its top-level key, and all the service accounts / [Application Default Credentials (ADC)](https://cloud.google.com/docs/authentication/provide-credentials-adc) as nested keys.

```yaml
my-gcp-project-id:
  adc: |
    {
        "account": "",
        "client_id": "",
        "client_secret": "",
        "quota_project_id": "",
        "refresh_token": "",
        "type": "authorized_user",
        "universe_domain": "googleapis.com"
    }
  my-service-account: |
    {
        "type": "service_account",
        "project_id": "the GCP project ID",
        "private_key_id": "...",
        "...": "..."
    }
```

> [!NOTE]
> The reason to have the GCP project ID as the top-level key in the YAML file is that it allows us to create a "namespace" for the nested keys. In the NixOS module where we configure sops-nix we can set `sops.secrets."my-gcp-project-id/my-service-account"`, and at runtime we can access the unencrypted secret with a command like `cat /run/secrets/my-gcp-project-id/my-service-account`.

### Service accounts

Go to the GCP Console, navigate to the IAM & Admin > Service accounts page, download the JSON key of each service account, and copy its content to the YAML file.

### Application Default Credentials (ADC)

Obtain the Application Default Credentials (ADC) by [authenticating with gcloud](https://googleapis.dev/python/google-api-core/latest/auth.html).

```sh
gcloud auth application-default login
```

> [!NOTE]
> The reason to store the encrypted Application Default Credentials (ADC) for each GCP project in this repository is that in this way I consistently use the same credentials for a specific GCP project, across all my machines.

## Encrypt the YAML file using SOPS

Obviously, the YAML file should be encrypted before committing it to the repository.

```sh
GCP_PROJECT_ID=my-gcp-project-id && \
sops --config secrets/.sops.yaml \
--encrypt "secrets/gcp/$GCP_PROJECT_ID.yaml" > "secrets/gcp/$GCP_PROJECT_ID.sops.yaml"
```

## Remove the unencrypted YAML file

First, double check that you can decrypt the encrypted file using SOPS.

```sh
sops secrets/gcp/my-gcp-project-id.sops.yaml
```

Then, remove `my-gcp-project-id.yaml` (unencrypted file) and commit `my-gcp-project-id.sops.yaml` (encrypted file).

## Update the `secrets.nix` NixOS module

Add all the secrets declared in the SOPS file, to `config` section in the `secrets.nix` file. For example:

```nix
config = {
  sops.secrets."my-gcp-project-id/adc" = {
    inherit group mode owner;
    sopsFile = ../../secrets/gcp/my-gcp-project-id.sops.yaml;
  };
  sops.secrets."my-gcp-project-id/some-service-account" = {
    inherit group mode owner;
    sopsFile = ../../secrets/gcp/my-gcp-project-id.sops.yaml;
  };
}
```

## Opt. Update the `debug-secrets.nix` script

Update the `debug-secrets.nix` script to print the path to the secret and its content. For example:

```nix
printf "\nGCP Application Default Credentials (ADC) my-gcp-project-id/adc\n"
echo "secret found at ${secrets."my-gcp-project-id/adc".path}"
echo "secret is $(cat ${secrets."my-gcp-project-id/adc".path})"
```

## Switch NixOS configuration

Finally, switch to the new NixOS configuration to provision the secrets to the current machine.

```sh
sudo nixos-rebuild switch --flake $HOME/repos/nix-config#$(hostname)
```
