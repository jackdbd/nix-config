# nixos modules

**System-wide** configuration for programs.

Nix packages that include one or more programs can provide a NixOS module and/or a home-manager module (for example, [sops-nix](https://github.com/Mic92/sops-nix) provides both). This directory contains the user-wide configuration for programs that were **installed at the system-level**.

**Do** search on [NixOS options](https://search.nixos.org/options) (e.g. `programs.tmux.withUtempter`).

**Do not** search on [Home Manager Configuration Options](https://nix-community.github.io/home-manager/options.html), as those options are for home-manager modules.

> ⚠️ **Don't mix nixos configuration with home-manager configuration!**
>
> Configuration options for programs that are available as nixos modules can be different for the ones available as home-manager modules. Here are two examples:
>
> - The [nixos module for tmux](https://github.com/NixOS/nixpkgs/blob/master/nixos/modules/programs/tmux.nix) has a `programs.tmux.withUtempter` option, while the [home-manager module for tmux](https://github.com/nix-community/home-manager/blob/master/modules/programs/tmux.nix) hasn't.
> - There is a [home-manager module for rofi](https://github.com/nix-community/home-manager/blob/master/modules/programs/rofi.nix), but there is no nixos module for rofi.

## bluetooth

Configuration for [BlueZ](https://www.bluez.org/), [bluetoothd](https://linux.die.net/man/8/bluetoothd) (and the systemd service that invokes it) and [Blueman](https://wiki.archlinux.org/title/Blueman).

## secrets

NixOS module that takes care of provisioning the secrets on my machines using [sops-nix](https://github.com/Mic92/sops-nix).

## syncthing

Configure peer-to-peer file synchronization across all of my hosts with [Syncthing](https://nixos.wiki/wiki/Syncthing).

## Tailscale

Thanks to Tailscale's [MagicDNS](https://tailscale.com/kb/1081/magicdns), I can connect to other machines without knowing their IP. Here is how I can access my Debian VM via SSH, as the user `giacomo`:

```sh
ssh giacomo@debian-vm
```
