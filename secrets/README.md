# secrets

Sensitive configuration in this repository is encrypted with [age](https://github.com/FiloSottile/age) and edited with [SOPS](https://github.com/getsops/sops) when I need to update it (e.g. rotate a [GitHub personal access token](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/managing-your-personal-access-tokens) every 3 months). [sops-nix](https://github.com/Mic92/sops-nix) takes care of provisioning these secrets on my machines.

TODO: sops-nix is currently [installed using nix-channel](https://github.com/Mic92/sops-nix?tab=readme-ov-file#nix-channel). I would like to [install it as a nix flake](https://github.com/Mic92/sops-nix?tab=readme-ov-file#flakes-current-recommendation).

## ThinkPad X220

The SOPS configuration file `.sops.yaml` allows this age **public** key:

```txt
created: 2023-12-07T18:47:18+01:00
public key: age1wepxydgqnud4keawpf3ge3ylck8cjeewu4h6y34jtkg5urz5k3pq9dasm9
```

The age **private** key is deployed on my ThinkPad X220 and stored at `~/.config/sops/age/keys.txt`.

## Reference

- [Comparison of secret managing schemes](https://nixos.wiki/wiki/Comparison_of_secret_managing_schemes)

## Edit a secret

From the repository root, open `secrets.yaml` using the SOPS CLI and edit the value (which sops automatically decrypts using the age private key found at `~/.config/sops/age/keys.txt`).

```sh
sops secrets/secrets.yaml
```
