# nix-config

[NixOS](https://nixos.org/) and [Home Manager](https://nixos.wiki/wiki/Home_Manager) configuration for my machines.

## Installation / Update

From **this directory**, apply **both** the NixOS configuration and the Home Manager configuration:

```sh
sudo nixos-rebuild switch --flake ./#x220-nixos --show-trace --verbose
```

From **this directory**, apply **only** the Home Manager configuration:

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

## Useful commands

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
