# nix-config

[NixOS](https://nixos.org/) and [Home Manager](https://nixos.wiki/wiki/Home_Manager) configuration for my machines.

From **this directory**, apply system-wide changes:

```sh
sudo nixos-rebuild switch -I nixos-config=./machines/x220/configuration.nix --verbose
```

Almost all user-wide configuration is managed by Home Manager. At the moment (TODO) I am **not** using [Home Manager as a NixOS module](https://nix-community.github.io/home-manager/index.xhtml#sec-install-nixos-module).

From **this directory**, apply user-wide configuration with Home Manager [standalone installation](https://nix-community.github.io/home-manager/index.xhtml#sec-install-standalone) (which does not require `sudo`):

```sh
home-manager -f ./users/jack.nix switch
```

## Useful commands

Delete all `/nix/store` paths older than 7 days:

```sh
sudo nix-collect-garbage --delete-older-than 7d
```
