# Setup a new NixOS machine

This document assumes that you have already [installed NixOS](https://nixos.wiki/wiki/NixOS_Installation_Guide) in some way (e.g. using a USB stick) and that you just have to configure it.

## SSH keypair

Generate an SSH keypair, start the SSH agent and store both public/private key on the computer.

```sh
ssh-keygen -t ed25519 -C "john.smith@acme.com"
eval $(ssh-agent -s)
ssh-add $HOME/.ssh/id_ed25519
```

Double check that the SSH agent has loaded the SSH key you have just generated.

```sh
ssh-add -l
```

## Git repository

If git is not yet available on the new NixOS machine, install it using [nix-env](https://nixos.org/manual/nix/stable/command-ref/nix-env).

```sh
nix-env --install git
```

Configure your name and email.

```sh
git config --global user.name "John Smith"
git config --global user.email "john.smith@acme.com"
```

Optional: create a directory for all of your repositories (e.g. `mkdir ~/repos/`).

Clone the [nix-config](https://github.com/jackdbd/nix-config) repository from GitHub using SSH.

```sh
git clone git@github.com:jackdbd/nix-config.git
```

Remove git using nix-env, to prevent conflicts with the one declared in the NixOS configuration.

```sh
nix-env -e git
```

## NixOS + Home Manager configuration

From **the root of this repository**, apply **both** the NixOS configuration and the Home Manager for this host.

```sh
sudo nixos-rebuild switch \
  --flake $HOME/repos/nix-config#$(hostname)
```
