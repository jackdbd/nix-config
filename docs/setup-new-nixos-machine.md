# Setup a new NixOS machine

This document will guide in configuring NixOS, starting from a fresh new NixOS installation. This document assumes that you have already [installed NixOS](https://nixos.wiki/wiki/NixOS_Installation_Guide) in some way (e.g. [using a USB stick](./create-bootable-USB-stick.md)).

## Install a password manager

A fresh NixOS installation should have Firefox as the default browser. Install a password manager like LastPass as a Firefox extension.

## Setup SSH

### Generate an SSH keypair

In order to clone the git repo [nix-config](https://github.com/jackdbd/nix-config) from GitHub, you will need to generate an SSH keypair and upload the SSH public key to GitHub.

Generate an SSH keypair, start the SSH agent and store both the public key and the private key on the computer.

```sh
ssh-keygen -t ed25519 -C "john.smith@acme.com"
eval $(ssh-agent -s)
ssh-add $HOME/.ssh/id_ed25519
```

Double check that the SSH agent has loaded the SSH key you have just generated.

```sh
ssh-add -l
```

> ℹ️ If you have an hardware device like the Trezor, you can [store your SSH private key/s](https://trezor.io/learn/a/ssh-with-trezor) there.
>
> If you trust your password manager, you can also store your SSH private key on it.

### Copy the SSH public key to GitHub

Copy the SSH public key and paste it on GitHub, in `Settings` > `SSH and GPG keys` > `New SSH key`.

```sh
cat $HOME/.ssh/id_ed25519.pub
```

## Clone git repository

If git is not yet available on the new NixOS machine, install it using [nix-env](https://nixos.org/manual/nix/stable/command-ref/nix-env).

```sh
nix-env --install git
```

Set your name and email in the git global config.

```sh
git config --global user.name "John Smith"
git config --global user.email "john.smith@acme.com"
```

Create a directory for all of your repositories:

```sh
mkdir ~/repos
```

Clone the [nix-config](https://github.com/jackdbd/nix-config) repository from GitHub using SSH.

```sh
git clone git@github.com:jackdbd/nix-config.git
```

## Setup age

My NixOS configurations contain some [age](https://github.com/FiloSottile/age)-encrypted [secrets](../secrets/README.md). These secrets are automatically encrypted and decrypted by [sops-nix](https://github.com/Mic92/sops-nix), provided that age is installed and that there is a valid age private key on the machine that uses sops-nix.

### Install age

Install age using `nix-env`.

```sh
nix-env --install age
```

If that doesn't work, install Go and compile age.

```sh
nix-env --install go
go install filippo.io/age/cmd/...@latest
```

### Generate an age keypair and add the age public key

In order to decrypt the age-encrypted secrets found in this repository, you will need to generate an age keypair, copy the age **public** key and paste it in [this .sops.yaml file](../secrets/.sops.yaml).

```sh
mkdir -p ~/.config/sops/age

age-keygen -o ~/.config/sops/age/keys.txt
```

> ℹ️ If you have an hardware device like the Trezor, you can store your age private key there.
>
> If you trust your password manager, you can also store your age private key on it.

### Update all `.sops` files to accept the new age key

On a **machine that can already decrypt** age-encrypted secrets, update all `.sops` files to accept the new age key.

```sh
cd ~/repos/nix-config/secrets

sops updatekeys secrets.sops.yaml
sops updatekeys aws/default.sops.yaml
sops updatekeys gcp/prj-kitchen-sink.sops.yaml
# etc...
```

Double check that the new computer can decrypt age-encrypted secrets using sops.

```sh
cd ~/repos/nix-config/secrets

sops secrets.sops.yaml
```

## NixOS configuration

A fresh NixOS installation will probably have no editor (not event `vi`!). You can install VS Code using `nix-env`. Don't forget to set the environment variable `NIXPKGS_ALLOW_UNFREE` to `1`, since VS Code is an unfree package.

```sh
export NIXPKGS_ALLOW_UNFREE=1
nix-env --install code
```

On a fresh new NixOS installation, the entire configuration of your system will be stored in two files:

- `/etc/nixos/configuration.nix`
- `/etc/nixos/hardware-configuration.nix`

Let's say that your new NixOS host is a ThinkPad L390. You can create a subdirectory in this repository and store the configuration there.

```sh
mkdir -p ~/repos/nix-config/nixos/hosts/l390

cp /etc/nixos/* ~/repos/nix-config/nixos/hosts/l390/
```

You will also need to update the `flake.nix` file to include the new NixOS host configuration in`nixosConfigurations` and `homeConfigurations`.

## Switch the NixOS + Home Manager configuration

You are now ready to rebuild the NixOS configuration and switch to it. From **the root of this repository**, apply **both** the NixOS configuration and the Home Manager for this host (see `nixosConfigurations` in the `flake.nix`). For example:

```sh
sudo nixos-rebuild switch \
  --flake $HOME/repos/nix-config#l390-nixos
```

## Commit

Commit the configuration of your new NixOS host:

```sh
git add .
git commit -m 'add NixOS and Home Manager configuration for ThinkPad L390'
git push
```

> [!NOTE]
> The reason why you should commit these files is that [nix flakes do not include untracked files](https://github.com/NixOS/nix/issues/7107).

## Keep your flakes up-to-date

Run this command to update all nix flakes declared in your config:

```sh
git add .
git commit -m 'run nix flake update'
git push
```

## Cleanup

Uninstall all packages installed with `nix-env`, since they are now available in the NixOS / Home Manager configuration.

```sh
nix-env -e age
nix-env -e code
nix-env -e git
nix-env -e go
```
