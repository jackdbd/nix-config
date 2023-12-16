# nixos modules

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
