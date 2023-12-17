# Useful commands

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
