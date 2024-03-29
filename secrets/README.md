# Secrets

Any sensitive piece of configuration in this repository is encrypted with [age](https://github.com/FiloSottile/age).

Whenever I need to edit a secret (e.g. rotate a [GitHub personal access token](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/managing-your-personal-access-tokens) every 3 months), I decrypt that file on the fly using the [SOPS](https://github.com/getsops/sops) CLI, which also takes are of re-encrypting the file when I close it. The SOPS configuration file `.sops.yaml` specifies which age public keys to use for encryption.

The Nix package [sops-nix](https://github.com/Mic92/sops-nix) takes care of provisioning the secrets on my machines (it decrypts all secrets every time I run `nixos-rebuild`, then it stores them unencrypted on the target machine's filesystem).

On each one of my computers, my age public/private keys are stored at `~/.config/sops/age/keys.txt`. I'm considering [storing my age private keys on my Trezor](https://trezor.io/learn/a/public-private-keys).

## Create an age keypair

Generate a keypair (public key + private key).

```sh
mkdir -p ~/.config/sops/age

age-keygen -o ~/.config/sops/age/keys.txt
```

## Encrypt a secret

Encrypt a file using **all** age **public** keys specified in the `.sops.yaml` config file (only the corresponding age private keys will be able to decrypt the encrypted file).

```sh
sops --config secrets/.sops.yaml \
  --encrypt secrets.unencrypted.yaml > secrets/secrets.sops.yaml
```

That `.sops` before the file extension is just a convention of mine. [Other people](https://gitlab.com/K900/nix/-/tree/master/secrets) use `age` to signify that the file was encrypted using age.

## Edit a secret

Editing a secret means decrypting it and re-encrypting it.

```sh
sops --config secrets/.sops.yaml secrets/secrets.sops.yaml
```

You can omit `--config` if the SOPS config file is named `.sops.yaml`.

If not specified, the `sops` CLI tries decrypting a file using the age private keys found at `~/.config/sops/age/keys.txt`

## Decrypt a SOPS file

```sh
sops --config secrets/.sops.yaml --decrypt secrets/secrets.sops.yaml > secrets.unencrypted.yaml
```

## Update keys allowed to decrypt a SOPS file

Whenever a new **private** key should be allowed to decrypt a SOPS file (e.g. `secrets.sops.yaml`), we need to add the corresponding **public** key in `.sops.yaml`.

We also have to run `sops updatekeys` on that file.

```sh
cd ~/repos/nix-config/secrets

sops updatekeys secrets.sops.yaml
```

> ⚠️ The `sops updatekeys` command does not support passing a `--config` flag.

The file `secrets.sops.yaml` will now contain the updated keys. Here is an example with age keys.

```yaml
sops:
    age:
        - recipient: age1r5aen49ta9z55u3qutlass5zgru6w7xekdpvtz0v24qa9qexxszqy26pdk
          enc: |
            -----BEGIN AGE ENCRYPTED FILE-----
            encrypted string that only my ThinkPad L390 can decrypt
            -----END AGE ENCRYPTED FILE-----
        - recipient: age1wepxydgqnud4keawpf3ge3ylck8cjeewu4h6y34jtkg5urz5k3pq9dasm9
          enc: |
            -----BEGIN AGE ENCRYPTED FILE-----
            encrypted string that only my ThinkPad X220 can decrypt
            -----END AGE ENCRYPTED FILE-----
```

Repeat for each `.sops.yaml` file containing age-encrypted secrets.

```sh
sops updatekeys aws/default.sops.yaml
sops updatekeys gcp/prj-kitchen-sink.sops.yaml
```

## Reference

- [Comparison of secret managing schemes](https://nixos.wiki/wiki/Comparison_of_secret_managing_schemes)
