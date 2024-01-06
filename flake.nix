{
  description = "NixOS & Home Manager configuration for all of jackdbd's hosts";

  inputs = {
    # Get the current stable release of Nixpkgs from GitHub
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    # In alternative, get the current stable release of Nixpkgs from FlakeHub
    # https://flakehub.com/flake/NixOS/nixpkgs
    # nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/*.tar.gz";

    # Some packages might contain fixes/features that are available only in the
    # Nixpkgs unstable release. Instead of using the Nixpkgs unstable release
    # for everything, we use it only for such packages.
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    alejandra.url = "github:kamadorueda/alejandra/3.0.0";
    # alejandra has nixos-unstable-small among its flake inputs. You can check with:
    # nix flake metadata github:kamadorueda/alejandra/3.0.0
    # https://github.com/kamadorueda/alejandra/blob/e53c2c6c6c103dc3f848dbd9fbd93ee7c69c109f/flake.nix#L11C41-L11C61
    # Since this flake has home-manager among its inputs, and that home-manager
    # has nixpkgs-unstable among its inputs, we can make alejandra and
    # home-manager follow the same nixpkgs-unstable instance.
    alejandra.inputs.nixpkgs.follows = "nixpkgs-unstable";

    fh.url = "https://flakehub.com/f/DeterminateSystems/fh/*.tar.gz";

    # home-manager.url = "github:nix-community/home-manager";
    # home-manager has nixos-unstable among its flake inputs.
    # https://github.com/nix-community/home-manager/blob/51e44a13acea71b36245e8bd8c7db53e0a3e61ee/flake.nix#L4
    # home-manager.inputs.nixpkgs.follows = "nixpkgs-unstable";
    # If we want Home Manager to follow the latest nixpkgs stable release, we
    # need to specify the nixos-23.11 branch.
    home-manager.url = "github:nix-community/home-manager/release-23.11";
    # If we declare a stable nixpkgs release for home-manager (e.g. release-23.11),
    # it makes sense to follow the nixpkgs instance and not the nixpkgs-unstable one.
    # home-manager.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.inputs.nixpkgs.follows = "nixpkgs-unstable";

    # nil (Language Server for Nix expression) has nixos-unstable among its
    # flake inputs. You can check with:
    # nix flake metadata github:oxalica/nil
    # https://github.com/oxalica/nil
    # nil is not the only one Language Server available for Nix. There are also:
    # https://github.com/nix-community/nixd
    # https://github.com/nix-community/rnix-lsp
    nil.url = "github:oxalica/nil";
    nil.inputs.nixpkgs.follows = "nixpkgs-unstable";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs-unstable";
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

    pkgs = nixpkgs.legacyPackages.${system};
    pkgs-unstable = nixpkgs-unstable.legacyPackages.${system};

    # We can pass additional inputs to all NixOS modules using specialArgs.
    specialArgs = {inherit allowed-unfree-packages fh inputs nil nixos-hardware sops-nix user;};
    # We can pass additional inputs to all Home Manager modules using extraSpecialArgs.
    extraSpecialArgs = {inherit allowed-unfree-packages favorite-browser user;};
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
      modules = [./home-manager/users/${user}.nix];
      # pkgs = pkgs-unstable;
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
