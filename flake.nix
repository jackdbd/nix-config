{
  description = "NixOS & Home Manager configuration for all of jackdbd's hosts";

  inputs = {
    # Get the current stable Nixpkgs from GitHub
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    # Get the current stable Nixpkgs from FlakeHub
    # https://flakehub.com/flake/NixOS/nixpkgs
    # nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/*.tar.gz";

    # Some packages might contain fixes/features that are available only in the
    # Nixpkgs unstable release. So instead of using the Nixpkgs unstable release
    # for everything, we use it only for such packages.
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    alejandra = {
      url = "github:kamadorueda/alejandra/3.0.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    fh.url = "https://flakehub.com/f/DeterminateSystems/fh/*.tar.gz";

    home-manager = {
      # Home Manager is developed against nixpkgs-unstable branch.
      # url = "github:nix-community/home-manager";
      # inputs.nixpkgs.follows = "nixpkgs-unstable";
      # If we want Home Manager to follow the latest nixpkgs stable release, we
      # need to specify the nixos-23.11 branch.
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Language Server for Nix expression.
    # https://github.com/oxalica/nil
    # nil is not the only one Language Server available for Nix. There are also:
    # https://github.com/nix-community/nixd
    # https://github.com/nix-community/rnix-lsp
    nil.url = "github:oxalica/nil";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    sops-nix.url = "github:Mic92/sops-nix";
  };

  # Define the alias `inputs` to let all Nix modules access all inputs.
  outputs = {
    alejandra,
    fh,
    home-manager,
    nil,
    nixos-hardware,
    nixpkgs,
    nixpkgs-unstable,
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
      "vscode-extension-github-copilot"
      "vscode-extension-github-copilot-chat"
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
          home-manager.extraSpecialArgs = {inherit favorite-browser user;};
        }
      ];

      # Nix modules automatically receive as inputs: config, lib, modulesPath,
      # options, pkgs. If you want to pass additional inputs to Nix modules,
      # you need to do it explicitly using these specialArgs.
      specialArgs = {inherit allowed-unfree-packages fh inputs nil nixos-hardware nixpkgs sops-nix user;};
    };

    nixosConfigurations."x220-nixos" = nixpkgs.lib.nixosSystem rec {
      inherit system;

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
          home-manager.extraSpecialArgs = {inherit favorite-browser user;};
        }
      ];

      specialArgs = {inherit allowed-unfree-packages fh inputs nil nixos-hardware nixpkgs sops-nix user;};
    };

    # Standalone home-manager configuration entrypoint
    # Available through 'home-manager --flake .#your-username@your-hostname'
    homeConfigurations."${user}@L380" = home-manager.lib.homeManagerConfiguration {
      # Home-manager requires 'pkgs' instance
      pkgs = nixpkgs.legacyPackages.${system};
      extraSpecialArgs = {inherit allowed-unfree-packages favorite-browser user;};
      modules = [
        ./home-manager/users/${user}.nix
      ];
    };

    homeConfigurations."${user}@l390-nixos" = home-manager.lib.homeManagerConfiguration {
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
