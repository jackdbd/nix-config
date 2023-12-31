# NixOS

System-wide configuration for all of my hosts. This configuration consist of:

- configuring [initrd](https://en.wikipedia.org/wiki/Initial_ramdisk);
- configuring disk encryption with [LUKS](https://en.wikipedia.org/wiki/Linux_Unified_Key_Setup);
- configuring the boot loader (e.g. GRUB);
- making a package available system-wide, namely all users on the host will be able to use that package;
- configuring NixOS modules;
- configuring a service at the system level.

## Hosts

- [l390](./hosts/l390/configuration.nix): ThinkPad L390
- [x220](./hosts/x220/configuration.nix): ThinkPad X220

## Modules

My [NixOS modules](https://nixos.wiki/wiki/NixOS_modules).

> ⚠️ **Don't put [Home Manager modules](https://nix-community.github.io/home-manager/index.xhtml#ch-writing-modules) in this directory!**

## Reference

- [NixOS options](https://search.nixos.org/options)
- [Nix modules provided by nixos-hardware](https://github.com/NixOS/nixos-hardware/blob/master/flake.nix)
