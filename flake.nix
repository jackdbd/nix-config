{
  description = "NixOS & Home Manager configuration for all of jackdbd's hosts";

  inputs = {
    # Get the current stable release of Nixpkgs from FlakeHub
    # https://flakehub.com/flake/NixOS/nixpkgs
    # nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/*.tar.gz";
    # Get the current stable release of nixpkgs from GitHub
    # nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    # Get the current unstable release of nixpkgs from GitHub
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    alejandra.url = "github:kamadorueda/alejandra/3.0.0";
    # alejandra depends on nixos-unstable-small.
    alejandra.inputs.nixpkgs.follows = "nixpkgs";

    fh.url = "https://flakehub.com/f/DeterminateSystems/fh/*.tar.gz";

    home-manager.url = "github:nix-community/home-manager";
    # home-manager depends on nixos-unstable.
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nil.url = "github:oxalica/nil";
    # nil (Language Server for Nix expression) depends on nixos-unstable.
    nil.inputs.nixpkgs.follows = "nixpkgs";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    sops-nix.url = "github:Mic92/sops-nix";
    # sops-nix depends on nixos-unstable.
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
      "google-chrome"
      "obsidian"
      "postman"
      "vscode"
      "vscode-1.85.1"
      "vscode-extension-github-copilot"
      "vscode-extension-github-copilot-chat"
    ];
    permitted-insecure-pakages = [
      # Obsidian is build on Electron. I don't know why NixOS marks Electron as insecure.
      "electron-25.9.0"
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
    nixosConfigurations."l390-nixos" = nixpkgs.lib.nixosSystem {
      inherit specialArgs system;

      modules = [
        {
          environment.systemPackages = [alejandra.defaultPackage.${system}];
        }
        ./nixos/hosts/l390/configuration.nix
        # Declare home-manager as a NixOS module, so that all the home-manager
        # configuration will be deployed automatically when executing:
        # `sudo nixos-rebuild switch --flake ./#l390-nixos`
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
