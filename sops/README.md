# sops

This directory contains all my encrypted secrets.

Any sensitive piece of configuration in this repository is encrypted with [age](https://github.com/FiloSottile/age).

Whenever I need to edit a secret in `secrets.yaml` (e.g. rotate a [GitHub personal access token](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/managing-your-personal-access-tokens) every 3 months) I decrypt that file on the fly using [SOPS](https://github.com/getsops/sops), which also takes are of re-encrypting the `secrets.yaml` when I close it. The SOPS configuration file `.sops.yaml` specifies which age public keys to use for encryption.

The Nix package [sops-nix](https://github.com/Mic92/sops-nix) takes care of provisioning the secrets on my machines.

## ThinkPad X220

age **public** key:

```txt
created: 2023-12-07T18:47:18+01:00
public key: age1wepxydgqnud4keawpf3ge3ylck8cjeewu4h6y34jtkg5urz5k3pq9dasm9
```

The age **private** key is deployed on my ThinkPad X220 and stored at `~/.config/sops/age/keys.txt`.

## Create an age keypair

Generate a keypair (public key + private key).

```sh
age-keygen -o ~/.config/sops/age/keys.txt
```

TODO: add explanation.

## Edit a secret

From the repository root, open `secrets.yaml` using the SOPS CLI and edit the value (which sops automatically decrypts using the age private key found at `~/.config/sops/age/keys.txt`).

```sh
sops sops/secrets.yaml
```

## Reference

- [Comparison of secret managing schemes](https://nixos.wiki/wiki/Comparison_of_secret_managing_schemes)
