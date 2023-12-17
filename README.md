# nix-config

[NixOS](https://nixos.org/) and [Home Manager](https://nixos.wiki/wiki/Home_Manager) configuration for my machines.

## Installation / Update

### NixOS hosts

From **the root of this repository**, apply **both** the NixOS configuration and the Home Manager configuration:

```sh
sudo nixos-rebuild switch --flake ./#x220-nixos --show-trace --verbose
```

From **the root of this repository**, apply **only** the Home Manager configuration:

```sh
home-manager switch \
  --extra-experimental-features nix-command \
  --extra-experimental-features flakes \
  --flake .#jack@x220-nixos
```

> ℹ️ As long as the configuration of a host (e.g. `nixos/hosts/x220/configuration.nix`) includes `nix.settings.experimental-features = [ "nix-command" "flakes" ];` the `--extra-experimental-features` flags can be omitted.

```sh
home-manager switch --flake .#jack@x220-nixos
```

### Non-NixOS hosts

Install [Nix: the package manager](https://nixos.org/download).

```sh
sh <(curl -L https://nixos.org/nix/install) --daemon
```

Install Home Manager (read [here if you have any issues on Ubuntu](https://discourse.nixos.org/t/installing-home-manager-on-ubuntu/25957/)).

```sh
nix-env --install home-manager
```

From **the root of this repository**, apply **only** the Home Manager configuration:

```sh
home-manager switch \
  --extra-experimental-features nix-command \
  --extra-experimental-features flakes \
  --extra-experimental-features auto-allocate-uids \
  --extra-experimental-features configurable-impure-env \
  --flake .#jack@l380
```

## Useful commands

Update all dependencies of this flake and recreate the lock file.

```sh
nix flake update --commit-lock-file
```

Format all nix code with [alejandra](https://github.com/kamadorueda/alejandra) (keep in mind that the [kamadorueda.alejandra](https://marketplace.visualstudio.com/items?itemName=kamadorueda.alejandra) VS Code extension formats a nix file on save):

```sh
alejandra .
```

Perform garbage collection on the Nix store:

```sh
nix store gc --debug
```

Optimize the Nix store (this takes some time):

```sh
nix-store --optimise
```

## Docs

- [Setup a new NixOS machine](./docs/setup-new-nixos-machine.md)
