# Setup a new NixOS machine

This document will guide in configuring a new computer, starting from a fresh new NixOS installation. This document assumes that you have already [installed NixOS](https://nixos.wiki/wiki/NixOS_Installation_Guide) in some way (e.g. [using a USB stick](./create-bootable-USB-stick.md)).

The whole process should take **a bit more than an hour**, excluding compilation times (which could be significant).

## 1. Install a password manager

A fresh NixOS installation should have Firefox as the default browser. Install a password manager like LastPass as a Firefox extension.

## 2. Setup SSH

### Generate an SSH keypair

In order to clone git repositories from GitHub using SSH, you will need to generate an SSH keypair and upload the SSH public key to GitHub.

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

### Copy the SSH public key to GitHub

Copy the SSH public key and paste it on GitHub, in `Settings` > `SSH and GPG keys` > `New SSH key`.

```sh
cat $HOME/.ssh/id_ed25519.pub
```

### Optional: store the SSH keypair somewhere safe

You may consider [backing up the SSH keypair](https://unix.stackexchange.com/questions/13871/should-i-be-backing-up-my-ssh-host-keys) in a safe place:

- If you have an hardware device like the Trezor, you can [store your SSH keypair](https://trezor.io/learn/a/ssh-with-trezor) there.
- If you trust your password manager, you can store your SSH keypair there.
- If you have a USB stick you consider safe (e.g. a USB stick that never leaves your home), you can store your SSH keypair there.

## 3. Clone this repository

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

## 4. Setup age

All of my NixOS configurations for my computers contain some [age](https://github.com/FiloSottile/age)-encrypted [secrets](../secrets/README.md). These secrets are automatically encrypted and decrypted by [sops-nix](https://github.com/Mic92/sops-nix), provided that age is installed and that there is a valid age private key on the machine that uses sops-nix.

### Install age

Since age is not yet available on the new NixOS machine, you'll have to install it using `nix-env`.

```sh
nix-env --install age
```

If that doesn't work, install Go and compile age.

```sh
nix-env --install go
go install filippo.io/age/cmd/...@latest
```

> ℹ️ If you had to install Go and compile age, you will find the `age` and `age-keygen` binaries in `$HOME/go/bin`.

### Generate an age keypair and add the age public key

In order to decrypt the age-encrypted secrets found in this repository, you will need to generate an age keypair, copy the age **public** key and paste it in [this .sops.yaml file](../secrets/.sops.yaml).

```sh
mkdir -p ~/.config/sops/age

age-keygen -o ~/.config/sops/age/keys.txt
```

### Add the age public key to the list of authorized keys

Copy the age public key and paste it in the `.sops.yaml` file of this repository. Give it a name to clearly identify the authorized device.

Add the age public key to the list of authorized keys listed in the `secrets/.sops.yaml` file in this repository.

### Optional: store the age keypair somewhere safe

You may consider backing up the age keypair:

If you have an hardware device like the Trezor, you can store your age keypair there.
If you trust your password manager, you can store your age keypair there.
If you have a USB stick you consider safe (e.g. a USB stick that never leaves your home), you can store your age keypair there.

### Update all `.sops` files to accept the new age key

On a **machine that can already decrypt** age-encrypted secrets, update all `.sops` files to accept the new age key.

```sh
cd ~/repos/nix-config/secrets

sops updatekeys secrets.sops.yaml
sops updatekeys aws/default.sops.yaml
sops updatekeys gcp/prj-kitchen-sink.sops.yaml
# etc...
```

Push the changes to the repository.

```sh
cd ~/repos/nix-config
git add secrets/
git commit -m 'add new age key in SOPS files'
git push
```

On the new NixOS machine, pull the changes.

```sh
cd ~/repos/nix-config
git pull
```

Double check that the new computer can decrypt age-encrypted secrets using sops.

```sh
cd ~/repos/nix-config/secrets

sops secrets.sops.yaml
```

## 5. NixOS configuration

A fresh NixOS installation will probably have no editor (not even `vi`!). You can install VS Code using `nix-env`. Don't forget to set the environment variable `NIXPKGS_ALLOW_UNFREE` to `1`, since VS Code is an unfree package.

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

> [!IMPORTANT]
> Make sure your new NixOS computer is configured with [full-disk encryption](https://nixos.wiki/wiki/Full_Disk_Encryption). Double check that in your `configuration.nix` there is a line that says `boot.initrd.luks.devices`.

You will also need to update the `flake.nix` file to include the new NixOS host configuration in `nixosConfigurations` and `homeConfigurations`.

```sh
cd ~/repos/nix-config
git add .
git commit -m 'update NixOS configuration for <DEVICE>' # e.g. ThinkPad L390
git push
```

> [!WARNING]
> The reason why you should commit these files is that [nix flakes do not include untracked files](https://github.com/NixOS/nix/issues/7107).

## 6. Switch the NixOS + Home Manager configuration

You are now ready to rebuild the NixOS configuration and switch to it. From **the root of this repository**, apply **both** the NixOS configuration and the Home Manager for this host (see `nixosConfigurations` in the `flake.nix`).

For example:

```sh
sudo nixos-rebuild switch \
  --flake $HOME/repos/nix-config#l390-nixos
```

## 7. Cleanup

Uninstall all packages installed with `nix-env`, since they are now available in the NixOS / Home Manager configuration.

```sh
nix-env -e age
nix-env -e code
nix-env -e git
nix-env -e go
```
