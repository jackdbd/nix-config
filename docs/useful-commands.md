# Useful commands

## Update dependencies

Update all dependencies of this flake and recreate the lock file.

```sh
nix flake update --commit-lock-file
```

Don't forget to commit the changes every time you update the flakes this repository depends on:

```sh
git add .
git commit -m 'nix flake update'
git push
```

## Format nix code

Format all nix code with [alejandra](https://github.com/kamadorueda/alejandra) (keep in mind that the [kamadorueda.alejandra](https://marketplace.visualstudio.com/items?itemName=kamadorueda.alejandra) VS Code extension formats a nix file on save):

```sh
alejandra .
```

## Nix store optimization and cleanup

Perform garbage collection on the Nix store:

```sh
nix store gc --debug
```

Optimize the Nix store (this takes some time):

```sh
nix-store --optimise
```

Remove Home-Manager generations older than a given date:

```sh
home-manager expire-generations "2023-12-31 23:59"
```
