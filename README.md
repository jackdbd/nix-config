# nix-config

[NixOS](https://nixos.org/) and [Home Manager](https://nixos.wiki/wiki/Home_Manager) configuration for my machines.

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
