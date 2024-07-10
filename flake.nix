{
  description = "NixOS & Home Manager configuration for all of jackdbd's hosts";

  inputs = {
    # Option 1: Get a release of nixpkgs from GitHub (see active branches)
    # Most likely you'll want nixos-unstable.
    # https://discourse.nixos.org/t/differences-between-nix-channels/13998
    # https://github.com/NixOS/nixpkgs/branches
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # Option 2: Get a release of nixpkgs from FlakeHub
    # https://flakehub.com/flake/NixOS/nixpkgs
    # nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/*.tar.gz";

    alejandra.url = "github:kamadorueda/alejandra/3.0.0";
    # alejandra follows nixos-unstable-small
    # https://github.com/kamadorueda/alejandra/blob/e53c2c6c6c103dc3f848dbd9fbd93ee7c69c109f/flake.nix#L11C41-L11C61
    alejandra.inputs.nixpkgs.follows = "nixpkgs";

    fh.url = "https://flakehub.com/f/DeterminateSystems/fh/*.tar.gz";

    home-manager.url = "github:nix-community/home-manager";
    # home-manager follows nixos-unstable
    # https://github.com/nix-community/home-manager/blob/4ee704cb13a5a7645436f400b9acc89a67b9c08a/flake.nix#L4C10-L4C17
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nil.url = "github:oxalica/nil";
    # nil follows nixpkgs-unstable
    # https://github.com/oxalica/nil/blob/059d33a24bb76d2048740bcce936362bf54b5bc9/flake.nix#L6
    nil.inputs.nixpkgs.follows = "nixpkgs";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    sops-nix.url = "github:Mic92/sops-nix";
    # sops-nix follows nixpkgs-unstable.
    # https://github.com/Mic92/sops-nix/blob/2874fbbe4a65bd2484b0ad757d27a16107f6bc17/flake.nix#L3
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";
  };

  # Define the alias `inputs` to let all Nix modules access all inputs.
  outputs = {
    alejandra,
    fh,
    home-manager,
    nil,
    nixos-hardware,
    nixpkgs,
    self,
    sops-nix,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    user = "jack";

    # define the list of allowed unfree here, so I can pass it to both
    # `sudo nixos-rebuild` and `home-manager`
    allowed-unfree-packages = [
      "burpsuite"
      "google-chrome"
      "lmstudio"
      "mongodb-compass"
      "obsidian"
      "postman"
      "steam"
      "steam-original"
      "steam-run"
      "tarsnap"
      "vscode"
      "vscode-extension-github-copilot"
      "vscode-extension-github-copilot-chat"
      "vscode-extension-ms-vscode-remote-remote-containers" # Dev Containers
      "vscode-extension-ms-vsliveshare-vsliveshare"
    ];
    permitted-insecure-pakages = [
      # Obsidian is built on Electron. I don't know why NixOS marks Electron as insecure.
      "electron-25.9.0"
      # Some package (no idea which one) depends on v8-9.7.106.18, which nix marks as insecure.
      # Unfortunately the error nix gives us is not very actionable, as they say here:
      # https://github.com/NixOS/nixpkgs/issues/209804
      "v8-9.7.106.18"
    ];

    # TODO: define the font stack available to a specific user on a specific system
    favorite-browser = "google-chrome";

    pkgs = nixpkgs.legacyPackages.${system};

    # We can pass additional inputs to all NixOS modules using specialArgs.
    specialArgs = {inherit allowed-unfree-packages fh inputs nil nixos-hardware permitted-insecure-pakages sops-nix user;};
    # We can pass additional inputs to all Home Manager modules using extraSpecialArgs.
    extraSpecialArgs = {inherit allowed-unfree-packages favorite-browser permitted-insecure-pakages user;};
  in {
    # TODO: consider writing a function like this one:
    # https://github.com/mitchellh/nixos-config/blob/main/lib/mksystem.nix
    nixosConfigurations."l380-nixos" = nixpkgs.lib.nixosSystem {
      inherit specialArgs system;

      modules = [
        {
          environment.systemPackages = [alejandra.defaultPackage.${system}];
        }
        ./nixos/hosts/l380/configuration.nix
        # Declare home-manager as a NixOS module, so that all the home-manager
        # configuration will be deployed automatically when executing:
        # `sudo nixos-rebuild switch --flake ./#l380-nixos`
        # https://nixos-and-flakes.thiscute.world/nixos-with-flakes/start-using-home-manager#getting-started-with-home-manager
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.${user} = import ./home-manager/users/${user}.nix;
          home-manager.extraSpecialArgs = extraSpecialArgs;
        }
      ];
    };

    nixosConfigurations."l390-nixos" = nixpkgs.lib.nixosSystem {
      inherit specialArgs system;

      modules = [
        {
          environment.systemPackages = [alejandra.defaultPackage.${system}];
        }
        ./nixos/hosts/l390/configuration.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.${user} = import ./home-manager/users/${user}.nix;
          home-manager.extraSpecialArgs = extraSpecialArgs;
        }
      ];
    };

    nixosConfigurations."x220-nixos" = nixpkgs.lib.nixosSystem {
      inherit specialArgs system;

      modules = [
        {
          environment.systemPackages = [alejandra.defaultPackage.${system}];
        }
        ./nixos/hosts/x220/configuration.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.${user} = import ./home-manager/users/${user}.nix;
          home-manager.extraSpecialArgs = extraSpecialArgs;
        }
      ];
    };

    # Standalone home-manager configuration entrypoint (available both for NixOS machines and non-NixOS machines)
    # Available through 'home-manager --flake .#your-username@your-hostname'
    homeConfigurations."${user}@L380" = home-manager.lib.homeManagerConfiguration {
      inherit extraSpecialArgs pkgs;
      modules = [
        ./home-manager/users/${user}.nix
        ./home-manager/modules/syncthing.nix
      ];
    };

    homeConfigurations."${user}@l380-nixos" = home-manager.lib.homeManagerConfiguration {
      inherit extraSpecialArgs pkgs;
      modules = [./home-manager/users/${user}.nix];
    };

    homeConfigurations."${user}@l390-nixos" = home-manager.lib.homeManagerConfiguration {
      inherit extraSpecialArgs pkgs;
      modules = [./home-manager/users/${user}.nix];
    };

    homeConfigurations."${user}@x220-nixos" = home-manager.lib.homeManagerConfiguration {
      inherit extraSpecialArgs pkgs;
      modules = [./home-manager/users/${user}.nix];
    };
  };
}
