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

As long as there is `nix.settings.experimental-features = [ "nix-command" "flakes" ];` in `configuration.nix`, you can omit the `--extra-experimental-features` flag.

```sh
home-manager switch --flake .#jack@x220-nixos
```

## Useful commands

Perform garbage collection on the Nix store:

```sh
nix store gc --debug
```

Optimize the Nix store (this takes some time):

```sh
nix-store --optimise
```

TODO: Consider running the garbage collection automatically and auto-optimising the Nix store [as described here](https://nixos-and-flakes.thiscute.world/nixos-with-flakes/other-useful-tips#reducing-disk-usage).
