# Setup a new generic Linux machine

This document assumes that you have already installed a Linux distro in some way (e.g. using a USB stick).

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

## Nix

Install Nix using the [multi-user installation script](https://nixos.org/download).

```sh
sh <(curl -L https://nixos.org/nix/install) --daemon
```

Open a new terminal and very that Nix was installed correctly.

```sh
nix --version
```

Add the following to nix.conf (located at `~/.config/nix/nix.conf` or `/etc/nix/nix.conf`).

```text
experimental-features = nix-command flakes auto-allocate-uids
```

> ℹ️ Setting `experimental-features` in `nix.conf` saves us from having to type `--extra-experimental-features` when running `nix` or `nix flake` commands.

Restart the nix daemon:

```sh
sudo systemctl restart nix-daemon.service
```

## Git repository

Install git using the default package manager of your Linux distro (e.g. apt for Debian, Ubuntu, etc). I'm not sure why, but installing git using [nix-env](https://nixos.org/manual/nix/stable/command-ref/nix-env) causes some conflicts with Home Manager.

```sh
sudo apt install git
```

Configure your name and email.

```sh
git config --global user.name "John Smith"
git config --global user.email "john.smith@acme.com"
```

Optional: create a directory for all of your repositories (e.g. `mkdir ~/repos/`).

[Add the SSH public key to your GitHub account](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account).

Clone the [nix-config](https://github.com/jackdbd/nix-config) repository from GitHub using SSH.

```sh
git clone git@github.com:jackdbd/nix-config.git
```

## Home Manager configuration

Install Home Manager using [nix-env](https://nixos.org/manual/nix/stable/command-ref/nix-env) (read [here if you have any issues on Ubuntu](https://discourse.nixos.org/t/installing-home-manager-on-ubuntu/25957/)).

```sh
nix-env --install home-manager
```

From **the root of this repository**, apply **only** the Home Manager configuration for this host:

```sh
home-manager switch \
  --extra-experimental-features nix-command \
  --extra-experimental-features flakes \
  --extra-experimental-features auto-allocate-uids \
  --extra-experimental-features configurable-impure-env \
  --flake .#jack@l380
```

> ℹ️ I think the flags `--extra-experimental-features auto-allocate-uids` and `--extra-experimental-features configurable-impure-env` are required by the `google-chrome` package. You can omit those `--extra-experimental-features` if you set `experimental-features` in `nix.conf` (see above).

## Nix code formatter

Install [alejandra](https://github.com/kamadorueda/alejandra) downloading the `x86_64-unknown-linux-musl` [prebuilt binary](https://github.com/kamadorueda/alejandra?tab=readme-ov-file#prebuilt-binaries), making it executable and moving it to `/usr/bin`:

```sh
chmod +x alejandra-x86_64-unknown-linux-musl
sudo mv alejandra-x86_64-unknown-linux-musl /usr/bin/alejandra
```

## OpenGL issues

If alacritty and kitty have some OpenGL issues, you might have to install/update [Mesa drivers](https://itsfoss.com/install-mesa-ubuntu/).
