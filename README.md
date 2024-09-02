# ❄️ nix-config

[![Built with Nix](https://img.shields.io/static/v1?logo=nixos&logoColor=white&label=&message=Built%20with%20Nix&color=41439a)](https://builtwithnix.org/)

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

## Docs

- [Create a bootable USB stick](./docs/create-bootable-USB-stick.md)
- [Setup a new NixOS machine](./docs/setup-new-nixos-machine.md)
- [Setup a new generic Linux machine](./docs/setup-new-generic-linux-machine.md)
- [Useful commands](./docs//useful-commands.md)

## Credits

I owe a lot to [Vimjoyer](https://www.youtube.com/@vimjoyer/videos) and his excellent videos on NixOS and Home Manager.

I also learned a lot by looking at other people's NixOS and Home Manager configurations. Here is a non exhaustive list of repositories I often look at for inspiration, and why I think they are worth mentioning.

### [cadey/nixos-configs](https://tulpa.dev/cadey/nixos-configs)

- it configures [many hosts](https://tulpa.dev/cadey/nixos-configs/src/branch/main/hosts) and [many users](https://tulpa.dev/cadey/nixos-configs/src/branch/main/common/users).

### [davidak/nixos-config](https://codeberg.org/davidak/nixos-config)

- it's well organized and well documented.
- it configures [20 hosts](https://codeberg.org/davidak/nixos-config/src/branch/main/machines), from laptops, to a [NAS](https://codeberg.org/davidak/nixos-config/src/branch/main/machines/nas), to a [Pinephone](https://codeberg.org/davidak/nixos-config/src/branch/main/machines/pinephone).
- it defines [many profiles](https://codeberg.org/davidak/nixos-config/src/branch/main/profiles).

### [fricklerhandwerk/settings](https://github.com/fricklerhandwerk/settings)

- it configures [many hosts](https://github.com/fricklerhandwerk/settings/tree/main/user/machines).
- it manages [several versions of nixpkgs](https://github.com/fricklerhandwerk/settings/tree/main/system/nixpkgs).
- it documents [how to deploy the configuration](https://github.com/fricklerhandwerk/settings/tree/main/user) to a new machine.
- it cites other Nix configurations to learn from.

### [gvolpe/nix-config](https://github.com/gvolpe/nix-config)

- it's well organized and well documented.
- it contains a few [notes](https://github.com/gvolpe/nix-config/tree/master/notes) that explain how to manage this configuration.
- it configures Neovim using an [external Nix flake](https://github.com/gvolpe/neovim-flake).
- it includes a [build script](https://github.com/gvolpe/nix-config/blob/master/build) to deploy the configuration to a new NixOS machine.

### [K900/nix](https://gitlab.com/K900/nix)

- it configures [many hosts](https://gitlab.com/K900/nix/-/tree/master/machines).
- it uses a nice way of [organizing age-encrypted secrets](https://gitlab.com/K900/nix/-/tree/master/secrets).

### [KiaraGrouwstra/cfg](https://github.com/KiaraGrouwstra/cfg)

- it's well documented.
- it has a [modular Home Manager configuration](https://github.com/KiaraGrouwstra/cfg/tree/main/home-manager/kiara).
- it has an extensive [hyprland configuration](https://github.com/KiaraGrouwstra/cfg/blob/main/home-manager/kiara/hyprland.nix).
- it includes a [cachix configuration](https://github.com/KiaraGrouwstra/cfg/tree/main/cachix).

### [Misterio77/nix-starter-configs/minimal](https://github.com/Misterio77/nix-starter-configs/tree/main/minimal)

- it's a great starter configuration for Nix beginners.
- it clearly separates the NixOS (system-wide) configuration from the Home Manager (user) configuration. As far as I know, [this pattern is followed by most of the Nix community](https://discourse.nixos.org/t/how-do-you-organize-your-configuration/7306).

### [ryan4yin/nix-config](https://github.com/ryan4yin/nix-config)

- it's well documented. There is a short README in almost any directory. This keeps the documentation focused on a small subset of the entire configuration. I really like this approach.
- the author wrote this [NixOS & Flakes Book](https://nixos-and-flakes.thiscute.world/preface).

### [TheMaxMur/NixOS-Configuration](https://github.com/TheMaxMur/NixOS-Configuration)

- it uses [impermanence](https://nixos.wiki/wiki/Impermanence) (as a Home Manager module) to remove files/directories that are not specified in the nix config.
- it uses [Disko](https://github.com/nix-community/disko) for declarative disk management: luks + lvm + btrfs.
- it uses [Stylix](https://github.com/danth/stylix) to customize the theme for the entire system and the software you use.

### [thiagokokada/nix-configs](https://github.com/thiagokokada/nix-configs)

- it's well documented.
- it defines a few [GitHub workflows](https://github.com/thiagokokada/nix-configs/tree/master/.github/workflows) to update Nix flakes.
- it has a [modular Home Manager configuration](https://github.com/thiagokokada/nix-configs/tree/master/home-manager).
- it cites other Nix configurations to learn from.

### Other

- [gianarb/dotfiles/nixos](https://github.com/gianarb/dotfiles/tree/main/nixos)
- [Configuration Collection on NixOS Wiki](https://nixos.wiki/wiki/Configuration_Collection)
