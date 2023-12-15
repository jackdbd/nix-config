# home-manager services

**User-wide** configuration for services.

Nix packages that include one or more services can provide a NixOS module and/or a home-manager module. This directory contains the user-wide configuration for services that were **installed either at the system-level, or at the user-level**.

**Do** search on [Home Manager Configuration Options](https://nix-community.github.io/home-manager/options.html) (e.g. `services.syncthing.extraOptions`).

**Do not** search on [NixOS options](https://search.nixos.org/options), as those options are for nixos modules.

> ⚠️ **Don't mix nixos configuration with home-manager configuration!**
>
> Configuration options for services that are available as nixos modules can be different for the ones available as home-manager modules. For example, the syncthing nixos module offers [more than 40 configuration options](https://search.nixos.org/options?channel=23.11&from=0&size=50&sort=relevance&type=packages&query=syncthing), while the syncthing home-manager modules offers only a few ones.
