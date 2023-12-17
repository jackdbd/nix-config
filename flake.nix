{
  description = "NixOS & Home Manager configuration for all of jackdbd's hosts";

  inputs = {
    # Pin the nixpkgs repository to its latest stable release.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    # Some packages might contain fixes/features that are available only in the
    # nixpkgs unstable release.
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    alejandra.url = "github:kamadorueda/alejandra/3.0.0";
    alejandra.inputs.nixpkgs.follows = "nixpkgs";

    home-manager = {
      # Home Manager is developed against nixpkgs-unstable branch. If we want
      # Home Manager to follow the latest nixpkgs stable release, we need to
      # specify the nixos-23.11 branch.
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    sops-nix.url = "github:Mic92/sops-nix";
  };

  # Define the alias `inputs` to let all Nix modules access all inputs.
  outputs = inputs @ {
    alejandra,
    home-manager,
    nixos-hardware,
    nixpkgs,
    self,
    sops-nix,
    ...
  }: let
    system = "x86_64-linux";
    user = "jack";
    # define the list of allowed unfree here, so I can pass it to both
    # `sudo nixos-rebuild` and `home-manager`
    allowed-unfree-packages = [
      "google-chrome"
      "postman"
      "vscode"
      "vscode-extension-github-copilot"
    ];
    # TODO: define the font stack available to a specific user on a specific system
    favorite-browser = "google-chrome";
  in {
    # TODO: consider writing a function like this one:
    # https://github.com/mitchellh/nixos-config/blob/main/lib/mksystem.nix
    nixosConfigurations."l390-nixos" = nixpkgs.lib.nixosSystem rec {
      inherit system;

      modules = [
        {
          # nix code formatter
          environment.systemPackages = [alejandra.defaultPackage.${system}];
        }
        ./nixos/hosts/l390/configuration.nix

        # Install home-manager as a module of nixos, so that home-manager
        # configuration will be deployed automatically when executing
        # `sudo nixos-rebuild switch --flake ./#l390-nixos`
        # https://nixos-and-flakes.thiscute.world/nixos-with-flakes/start-using-home-manager#getting-started-with-home-manager
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.${user} = import ./home-manager/users/${user}.nix;
          home-manager.extraSpecialArgs = {inherit favorite-browser user;};
        }
      ];

      # Nix modules automatically receive as inputs: config, lib, modulesPath,
      # options, pkgs. If you want to pass additional inputs to Nix modules,
      # you need to do it explicitly using these specialArgs.
      specialArgs = {inherit allowed-unfree-packages inputs nixos-hardware nixpkgs sops-nix user;};
    };

    nixosConfigurations."x220-nixos" = nixpkgs.lib.nixosSystem rec {
      inherit system;

      modules = [
        {
          # nix code formatter
          environment.systemPackages = [alejandra.defaultPackage.${system}];
        }
        ./nixos/hosts/x220/configuration.nix

        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.${user} = import ./home-manager/users/${user}.nix;
          home-manager.extraSpecialArgs = {inherit favorite-browser user;};
        }
      ];

      specialArgs = {inherit allowed-unfree-packages inputs nixos-hardware nixpkgs sops-nix user;};
    };

    # Standalone home-manager configuration entrypoint
    # Available through 'home-manager --flake .#your-username@your-hostname'
    homeConfigurations."${user}@l390-nixos" = home-manager.lib.homeManagerConfiguration {
      # Home-manager requires 'pkgs' instance
      pkgs = nixpkgs.legacyPackages.${system};
      extraSpecialArgs = {inherit allowed-unfree-packages favorite-browser user;};
      modules = [
        ./home-manager/users/${user}.nix
      ];
    };

    homeConfigurations."${user}@x220-nixos" = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.${system};
      extraSpecialArgs = {inherit allowed-unfree-packages favorite-browser user;};
      modules = [
        ./home-manager/users/${user}.nix
      ];
    };
  };
}
