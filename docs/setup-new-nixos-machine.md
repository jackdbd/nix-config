# Setup a new NixOS machine

This document will guide in configuring NixOS, starting from a fresh new NixOS installation. This document assumes that you have already [installed NixOS](https://nixos.wiki/wiki/NixOS_Installation_Guide) in some way (e.g. using a USB stick).

## Install a password manager

A fresh NixOS installation should have Firefox as the default browser. Install a password manager like LastPass as a Firefox extension.

## Generate an SSH keypair

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

Copy the SSH public key and paste it on GitHub, in `Settings` > `SSH and GPG keys` > `New SSH key`.

```sh
cat $HOME/.ssh/id_ed25519.pub
```

> ℹ️ If you have an hardware device like the Trezor, you can [store your SSH private key/s](https://trezor.io/learn/a/ssh-with-trezor) there.
>
> If you trust your password manager, you can also store your SSH private key on it.

## Generate an age keypair

In order to decrypt the [age](https://github.com/FiloSottile/age)-encrypted [secrets](../secrets/README.md) found in this repository, you will need to generate an age keypair, copy the age **public** key and paste it in [this .sops.yaml file](../secrets/.sops.yaml).

```sh
mkdir -p ~/.config/sops/age

age-keygen -o ~/.config/sops/age/keys.txt
```

> ℹ️ If you have an hardware device like the Trezor, you can store your age private key there.
>
> If you trust your password manager, you can also store your age private key on it.

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

## Explore the NixOS configuration

A fresh NixOS installation will probably have no editor (not event `vi`!). You can install VS Code using `nix-env`. Don't forget to set the environment variable `NIXPKGS_ALLOW_UNFREE` to `1`, since VS Code is an unfree package.

```sh
export NIXPKGS_ALLOW_UNFREE=1
nix-env --install code
```

Double check the device UUIDs in the `hardware-configuration.nix` of your NixOS host (e.g. `nixos/hosts/l390/hardware-configuration.nix`). They should match the UUIDs in `/etc/nixos/hardware-configuration.nix`

## Switch the NixOS + Home Manager configuration

You are now ready to rebuild the NixOS configuration and switch to it. From **the root of this repository**, apply **both** the NixOS configuration and the Home Manager for this host (see `nixosConfigurations` in the `flake.nix`). For example:

```sh
sudo nixos-rebuild switch \
  --flake $HOME/repos/nix-config#l390-nixos
```

Uninstall all packages installed with `nix-env`, since they are now available in the NixOS / Home Manager configuration.

```sh
nix-env -e code
nix-env -e git
```
